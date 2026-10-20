import 'package:flutter/material.dart';
import 'models/life_activity.dart';
import 'models/life_event.dart';
import 'pages/activity_management_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/quick_add_page.dart';
import 'pages/statistics_page.dart';
import 'services/activity_migration_service.dart';
import 'services/activity_repository.dart';
import 'services/life_event_storage.dart';
import 'core/theme/app_theme.dart';

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
  final LifeEventStorage _storage = LifeEventStorage();
  final ActivityRepository _activityRepository = ActivityRepository();
  final List<LifeEvent> _events = [];
  List<LifeActivity> _activities = [];
  Future<void> _saveQueue = Future<void>.value();
  int _selectedIndex = 0;
  bool _isLoading = true;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final savedEvents = await _storage.loadEvents();
      const migration = ActivityMigrationService();
      final needsMigration = migration.needsMigration(savedEvents);
      final loadedEvents = needsMigration
          ? migration.migrateEvents(savedEvents)
          : savedEvents;

      if (needsMigration) {
        await _storage.saveEvents(loadedEvents);
      }

      final loadedActivities = await _activityRepository.loadActivities();

      if (!mounted) return;
      setState(() {
        _events
          ..clear()
          ..addAll(loadedEvents);
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

  Map<String, int> get _records {
    final counts = <String, int>{};
    for (final event in _events) {
      counts[event.activityId] = (counts[event.activityId] ?? 0) + 1;
    }
    return counts;
  }

  
void _addRecord(String activityId) {
  debugPrint('Adding activity: $activityId');
  final now = DateTime.now();
  final event = LifeEvent(
    id: '${now.microsecondsSinceEpoch}_${_events.length}',
    activityId: activityId,
    occurredAt: now,
  );

  setState(() => _events.add(event));
  _saveEvents();

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
          const Icon(Icons.check_circle_rounded, color: AppColors.sage, size: 22),
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
        onPressed: () => _undoRecord(event.id),
      ),
    ),
  );

}


void _undoRecord(String eventId) {
  final index = _events.indexWhere((event) => event.id == eventId);
  if (index == -1) return;

  setState(() => _events.removeAt(index));
  _saveEvents();
}

void _saveEvents() {
  final snapshot = List<LifeEvent>.of(_events);

  _saveQueue = _saveQueue
      .then((_) => _storage.saveEvents(snapshot))
      .catchError((Object error) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Could not save your records. Please try again.'),
      ),
    );
  });
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

    final records = _records;
    final pages = [
      DashboardPage(
        records: records,
        activities: _activities,
        events: _events,
        onAdd: _addRecord,
        onShowAll: () => setState(() => _selectedIndex = 1),
      ),
      QuickAddPage(
        activities: _activities,
        records: records,
        onAdd: _addRecord,
        onManage: _openActivityManagement,
      ),
      StatisticsPage(events: _events, activities: _activities),
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
