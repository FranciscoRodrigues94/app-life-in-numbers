
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/life_controller.dart';
import 'controllers/mood_controller.dart';
import 'controllers/language_controller.dart';
import 'core/theme/app_theme.dart';
import 'models/life_activity.dart';
import 'models/life_category.dart';
import 'models/default_emotions.dart';
import 'pages/activity_management_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/quick_add_page.dart';
import 'pages/mood_page.dart';
import 'pages/statistics_page.dart';
import 'services/activity_repository.dart';
import 'services/category_repository.dart';
import 'features/onboarding/pages/welcome_page.dart';
import 'features/settings/pages/settings_page.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LanguageController.instance.load();
  runApp(const LifeInNumbersApp());
}

class LifeInNumbersApp extends StatelessWidget {
  const LifeInNumbersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LanguageController.instance,
      builder: (context, child) {
        return MaterialApp(
          title: 'Life in Numbers',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          locale: LanguageController.instance.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const AppEntryPage(),
        );
      },
    );
  }
}

class AppEntryPage extends StatefulWidget {
  const AppEntryPage({super.key});

  @override
  State<AppEntryPage> createState() => _AppEntryPageState();
}

class _AppEntryPageState extends State<AppEntryPage> {
  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();
  bool _isLoading = true;
  bool _showWelcome = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _checkWelcome();
  }

  Future<void> _checkWelcome() async {
    try {
      final completed = await _preferences.getBool('life_welcome_completed') ?? false;
      final savedName = await _preferences.getString('life_user_name') ?? '';
      if (!mounted) return;
      setState(() {
        _showWelcome = !completed && savedName.trim().isEmpty;
        _isLoading = false;
        _hasError = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_hasError) {
      return Scaffold(
        body: Center(
          child: FilledButton(
            onPressed: () {
              setState(() {
                _isLoading = true;
                _hasError = false;
              });
              _checkWelcome();
            },
            child: const Text('Retry'),
          ),
        ),
      );
    }
    if (_showWelcome) {
      return WelcomePage(
        onCompleted: () => setState(() => _showWelcome = false),
      );
    }
    return const MainPage();
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final LifeController _lifeController = LifeController();
  final MoodController _moodController = MoodController();
  final ActivityRepository _activityRepository = ActivityRepository();
  final CategoryRepository _categoryRepository = CategoryRepository();
  final SharedPreferencesAsync _profilePreferences = SharedPreferencesAsync();
  static const String _userNameKey = 'life_user_name';

  List<LifeActivity> _activities = [];
  List<LifeCategory> _categories = [];
  int _selectedIndex = 0;
  bool _isLoading = true;
  String? _loadError;
  String? _lastSaveError;
  String _userName = '';
  OverlayEntry? _recordNotice;
  Timer? _recordNoticeTimer;

  @override
  void initState() {
    super.initState();
    _lifeController.addListener(_onLifeChanged);
    _moodController.addListener(_onMoodChanged);
    _loadData();
  }

  void _onMoodChanged() {
    if (mounted) setState(() {});
  }

  void _onLifeChanged() {
    if (!mounted) return;
    setState(() {});

    final saveError = _lifeController.saveError;
    if (saveError == null) {
      _lastSaveError = null;
      return;
    }
    if (saveError == _lastSaveError) return;
    _lastSaveError = saveError;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final messenger = ScaffoldMessenger.maybeOf(context);
      if (messenger == null) return;

      messenger.removeCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          key: const Key('record_save_error_snackbar'),
          persist: false,
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.navy,
          duration: const Duration(seconds: 5),
          content: Row(
            children: [
              const Icon(Icons.error_outline_rounded, color: AppColors.peach),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  saveError,
                  style: AppTypography.body.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> _loadData() async {
    try {
      await _lifeController.loadEvents();
      await _moodController.loadEntries();
      if (_lifeController.error != null) {
        throw StateError(_lifeController.error!);
      }

      final loadedActivities = await _activityRepository.loadActivities();
      final loadedCategories = await _categoryRepository.loadCategories();
      final savedName = await _profilePreferences.getString(_userNameKey) ?? '';

      if (!mounted) return;
      setState(() {
        _activities = loadedActivities;
        _isLoading = false;
        _loadError = null;
        _categories = loadedCategories;
        _userName = savedName;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _loadError = 'Unable to load your saved data.';
      });
    }
  }

  void _hideRecordNotice() {
    _recordNoticeTimer?.cancel();
    _recordNoticeTimer = null;
    _recordNotice?.remove();
    _recordNotice?.dispose();
    _recordNotice = null;
  }

  void _showRecordNotice(String message, VoidCallback onUndo) {
    _hideRecordNotice();
    final topPadding = MediaQuery.viewPaddingOf(context).top + 12;
    final overlay = Overlay.of(context);

    _recordNotice = OverlayEntry(
      builder: (overlayContext) => Positioned(
        top: topPadding,
        left: 16,
        right: 16,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: -1, end: 0),
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic,
          builder: (context, progress, child) => Transform.translate(
            offset: Offset(0, progress * 64),
            child: Opacity(
              opacity: (1 + progress).clamp(0.0, 1.0),
              child: child,
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Material(
                key: const Key('record_added_snackbar'),
                elevation: 12,
                shadowColor: AppColors.navy.withValues(alpha: 0.18),
                color: AppColors.navy,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_rounded, color: AppColors.sage, size: 25),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          message,
                          style: AppTypography.body.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _hideRecordNotice();
                          onUndo();
                        },
                        child: const Text(
                          'Undo',
                          style: TextStyle(color: AppColors.sage),
                        ),
                      ),
                      IconButton(
                        onPressed: _hideRecordNotice,
                        tooltip: 'Dismiss notification',
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 18,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_recordNotice!);
    _recordNoticeTimer = Timer(
      const Duration(seconds: 3),
      _hideRecordNotice,
    );
  }

  void _addFeeling(String emotionId) {
    if (_moodController.isLoading || _moodController.error != null) return;
    final entry = _moodController.addFeeling(emotionId);
    final name = DefaultEmotions.primary
        .where((emotion) => emotion.id == emotionId)
        .map((emotion) => emotion.name)
        .firstOrNull ?? emotionId;

    _showRecordNotice('$name recorded', () {
      _moodController.removeFeeling(entry.id);
    });
  }

  Future<void> _previewWelcome() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomePage(
          onCompleted: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Future<void> _openSettings() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsPage(),
      ),
    );
  }

  Future<void> _editUserName() async {
    final textController = TextEditingController(text: _userName);
    try {
      final newName = await showDialog<String>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('What should we call you?'),
          content: TextField(
            controller: textController,
            autofocus: true,
            maxLength: 40,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              hintText: 'Your first name',
            ),
            onSubmitted: (value) => Navigator.pop(
              dialogContext,
              value.trim(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(
                dialogContext,
                textController.text.trim(),
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      );

      if (newName == null || !mounted) return;
      await _profilePreferences.setString(_userNameKey, newName);
      if (mounted) setState(() => _userName = newName);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to save your name.')),
        );
      }
    } finally {
      textController.dispose();
    }
  }

  void _addRecord(String activityId) {
    final event = _lifeController.addEvent(activityId);
    final activityName = _activities
        .where((activity) => activity.id == activityId)
        .map((activity) => activity.name)
        .firstOrNull ?? activityId;

    _showRecordNotice('$activityName added', () {
      _lifeController.removeEvent(event.id);
    });
  }

  String _formatEventDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day/$month/${date.year} at $hour:$minute';
  }

  Future<void> _openRecordHistory(String activityId) async {
    final activityName = _activities
        .where((activity) => activity.id == activityId)
        .map((activity) => activity.name)
        .firstOrNull ?? activityId;

    final activityEvents = _lifeController.events
        .where((event) => event.activityId == activityId)
        .toList()
      ..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));

    if (activityEvents.isEmpty) return;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.background,
      builder: (sheetContext) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              12,
              20,
              20 + MediaQuery.viewInsetsOf(sheetContext).bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activityName,
                  style: AppTypography.section.copyWith(fontSize: 29),
                ),
                const SizedBox(height: 6),
                Text(
                  'Select a record to remove.',
                  style: AppTypography.body.copyWith(
                    color: AppColors.mutedText,
                  ),
                ),
                const SizedBox(height: 18),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: activityEvents.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final event = activityEvents[index];

                      return Material(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        child: ListTile(
                          key: Key('record_history_${event.id}'),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          leading: const Icon(
                            Icons.history_rounded,
                            color: AppColors.navy,
                          ),
                          title: Text(
                            _formatEventDate(event.occurredAt),
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: Text(
                            'Recorded moment',
                            style: AppTypography.caption,
                          ),
                          trailing: IconButton(
                            key: Key('delete_record_${event.id}'),
                            tooltip: 'Delete record',
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.redAccent,
                            ),
                            onPressed: () async {
                              final confirmed = await showDialog<bool>(
                                context: sheetContext,
                                builder: (dialogContext) => AlertDialog(
                                  title: const Text('Delete this record?'),
                                  content: Text(
                                    'Remove the $activityName record from '
                                    '${_formatEventDate(event.occurredAt)}? '
                                    'This action cannot be undone.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                        dialogContext,
                                        false,
                                      ),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      key: const Key('confirm_delete_record'),
                                      onPressed: () => Navigator.pop(
                                        dialogContext,
                                        true,
                                      ),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.redAccent,
                                      ),
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirmed != true ||
                                  !mounted ||
                                  !sheetContext.mounted) {
                                return;
                              }

                              final removed = _lifeController.removeEvent(
                                event.id,
                              );
                              if (!removed) return;

                              if (sheetContext.mounted) {
                                Navigator.pop(sheetContext);
                              }
                              if (!mounted) return;

                              final messenger = ScaffoldMessenger.of(context);
                              messenger.removeCurrentSnackBar();
                              messenger.showSnackBar(
                                SnackBar(
                                  key: const Key('record_deleted_snackbar'),
                                  persist: false,
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 3),
                                  backgroundColor: AppColors.navy,
                                  content: Text(
                                    '$activityName record deleted',
                                    style: AppTypography.body.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openActivityManagement() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActivityManagementPage(
          repository: _activityRepository,
        ),
      ),
    );

    if (!mounted) return;
    try {
      final activities = await _activityRepository.loadActivities();
      if (!mounted) return;
      setState(() => _activities = activities);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to refresh activities.')),
      );
    }
  }

  @override
  void dispose() {
    _hideRecordNotice();
    _lifeController.removeListener(_onLifeChanged);
    _lifeController.dispose();
    _moodController.removeListener(_onMoodChanged);
    _moodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_loadError != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_loadError!),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _loadError = null;
                  });
                  _loadData();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final records = _lifeController.records;
    final events = _lifeController.events;
    final l10n = AppLocalizations.of(context)!;

    final pages = [
      Stack(
        children: [
          DashboardPage(
            records: records,
            activities: _activities,
            events: events,
            feelings: _moodController.entries,
            onShowMood: () => setState(() => _selectedIndex = 2),
            onAddFeeling: _addFeeling,
            userName: _userName,
            onEditName: _editUserName,
            onAdd: _addRecord,
            onRemove: _openRecordHistory,
            onShowAll: () => setState(() => _selectedIndex = 1),
          ),
          Positioned(
            right: 16,
            bottom: 80,
            child: FloatingActionButton.small(
              heroTag: 'open_settings',
              tooltip: 'Settings',
              backgroundColor: AppColors.navy,
              foregroundColor: Colors.white,
              onPressed: _openSettings,
              child: const Icon(Icons.settings_outlined),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton.small(
              heroTag: 'preview_welcome',
              tooltip: 'Preview Welcome',
              backgroundColor: AppColors.navy,
              foregroundColor: Colors.white,
              onPressed: _previewWelcome,
              child: const Icon(Icons.visibility_outlined),
            ),
          ),
        ],
      ),
      QuickAddPage(
        activities: _activities,
        categories: _categories,
        records: records,
        onAdd: _addRecord,
        onRemove: _openRecordHistory,
        onManage: _openActivityManagement,
      ),
      MoodPage(
        controller: _moodController,
        onShowNotice: _showRecordNotice,
      ),
      StatisticsPage(
        events: events,
        activities: _activities,
        feelings: _moodController.entries,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        key: const Key('main_navigation'),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: [
          NavigationDestination(
            key: Key('nav_home'),
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: l10n.navHome,
          ),
          NavigationDestination(
            key: Key('nav_add'),
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: l10n.navAdd,
          ),
          NavigationDestination(
            key: Key('nav_mood'),
            icon: Icon(Icons.favorite_border_rounded),
            selectedIcon: Icon(Icons.favorite_rounded),
            label: l10n.navMood,
          ),
          NavigationDestination(
            key: Key('nav_statistics'),
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: l10n.navStatistics,
          ),
        ],
      ),
    );
  }
}
