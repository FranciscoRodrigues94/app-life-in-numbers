import 'package:flutter/material.dart';

import 'controllers/life_controller.dart';
import 'core/theme/app_theme.dart';
import 'models/life_activity.dart';
import 'pages/activity_management_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/quick_add_page.dart';
import 'pages/statistics_page.dart';
import 'services/activity_repository.dart';
import 'models/life_category.dart';
import 'services/category_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LifeInNumbersApp());
}

class LifeInNumbersApp extends StatelessWidget {
  const LifeInNumbersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life in Numbers',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final LifeController _lifeController = LifeController();
  final ActivityRepository _activityRepository = ActivityRepository();
  List<LifeActivity> _activities = [];
  int _selectedIndex = 0;
  bool _isLoading = true;
  String? _loadError;
  String? _lastSaveError;
  final CategoryRepository _categoryRepository = CategoryRepository();
  List<LifeCategory> _categories = [];

  @override
  void initState() {
    super.initState();
    _lifeController.addListener(_onLifeChanged);
    _loadData();
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
      if (_lifeController.error != null) {
        throw StateError(_lifeController.error!);
      }

      final loadedActivities = await _activityRepository.loadActivities();
      final loadedCategories = await _categoryRepository.loadCategories();

      if (!mounted) return;
      setState(() {
        _activities = loadedActivities;
        _isLoading = false;
        _loadError = null;
        _categories = loadedCategories;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _loadError = 'Unable to load your saved data.';
      });
    }
  }

  void _addRecord(String activityId) {
    final event = _lifeController.addEvent(activityId);

    final activityName =
        _activities
            .where((activity) => activity.id == activityId)
            .map((activity) => activity.name)
            .firstOrNull ??
        activityId;

    final messenger = ScaffoldMessenger.of(context);
    messenger.removeCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        key: const Key('record_added_snackbar'),
        persist: false,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        backgroundColor: AppColors.navy,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: AppColors.sage,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '$activityName added',
                style: AppTypography.body.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'Undo',
          textColor: AppColors.sage,
          onPressed: () => _lifeController.removeEvent(event.id),
        ),
      ),
    );
  }

  String _formatEventDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day/$month/${date.year} at $hour:$minute';
  }

  Future<void> _openRecordHistory(String activityId) async {
    final activityName =
        _activities
            .where((activity) => activity.id == activityId)
            .map((activity) => activity.name)
            .firstOrNull ??
        activityId;

    final activityEvents =
        _lifeController.events
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
                                      onPressed: () =>
                                          Navigator.pop(dialogContext, false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      key: const Key('confirm_delete_record'),
                                      onPressed: () =>
                                          Navigator.pop(dialogContext, true),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.redAccent,
                                      ),
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirmed != true || !mounted || !sheetContext.mounted) return;

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
        builder: (context) =>
            ActivityManagementPage(repository: _activityRepository),
      ),
    );

    if (!mounted) return;
    try {
      final activities = await _activityRepository.loadActivities();
      if (!mounted) return;
      setState(() => _activities = activities);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to refresh activities.')),
      );
    }
  }

  @override
  void dispose() {
    _lifeController.removeListener(_onLifeChanged);
    _lifeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
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

    final pages = [
      DashboardPage(
        records: records,
        activities: _activities,
        events: events,
        onAdd: _addRecord,
        onRemove: _openRecordHistory,
        onShowAll: () => setState(() => _selectedIndex = 1),
      ),
      QuickAddPage(
        activities: _activities,
        categories: _categories,
        records: records,
        onAdd: _addRecord,
        onRemove: _openRecordHistory,
        onManage: _openActivityManagement,
      ),
      StatisticsPage(events: events, activities: _activities),
    ];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        key: const Key('main_navigation'),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            key: Key('nav_home'),
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            key: Key('nav_add'),
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: 'Add',
          ),
          NavigationDestination(
            key: Key('nav_statistics'),
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}
