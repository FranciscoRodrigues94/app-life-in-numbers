
import 'package:flutter/material.dart';
import 'controllers/life_controller.dart';
import 'core/theme/app_theme.dart';
import 'models/life_activity.dart';
import 'pages/activity_management_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/quick_add_page.dart';
import 'pages/statistics_page.dart';
import 'services/activity_repository.dart';

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

      if (!mounted) return;
      setState(() {
        _activities = loadedActivities;
        _isLoading = false;
        _loadError = null;
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

    final activityName = _activities
        .where((activity) => activity.id == activityId)
        .map((activity) => activity.name)
        .firstOrNull ?? activityId;

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
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
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to refresh activities.'),
        ),
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

    final pages = [
      DashboardPage(
        records: records,
        activities: _activities,
        events: events,
        onAdd: _addRecord,
        onShowAll: () => setState(() => _selectedIndex = 1),
      ),
      QuickAddPage(
        activities: _activities,
        records: records,
        onAdd: _addRecord,
        onManage: _openActivityManagement,
      ),
      StatisticsPage(
        events: events,
        activities: _activities,
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
