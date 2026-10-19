
import 'package:flutter/material.dart';
import 'models/life_event.dart';
import 'pages/dashboard_page.dart';
import 'pages/quick_add_page.dart';
import 'pages/statistics_page.dart';
import 'services/life_event_storage.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D9488)),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        useMaterial3: true,
      ),
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
  final List<LifeEvent> _events = [];
  Future<void> _saveQueue = Future<void>.value();
  int _selectedIndex = 0;
  bool _isLoading = true;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    try {
      final savedEvents = await _storage.loadEvents();
      if (!mounted) return;
      setState(() {
        _events.addAll(savedEvents);
        _isLoading = false;
        _loadError = null;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _loadError = 'Unable to load your saved records.';
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

  void _addRecord(String activity) {
    final now = DateTime.now();
    final event = LifeEvent(
      id: '${now.microsecondsSinceEpoch}_${_events.length}',
      activityId: activity,
      occurredAt: now,
    );

    setState(() => _events.add(event));

    final snapshot = List<LifeEvent>.of(_events);
    _saveQueue = _saveQueue.then((_) => _storage.saveEvents(snapshot)).catchError((Object error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save your records. Please try again.')),
      );
    });
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
          child: Padding(
            padding: const EdgeInsets.all(24),
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
                    _loadEvents();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final records = _records;
    final pages = [
      DashboardPage(records: records),
      QuickAddPage(records: records, onAdd: _addRecord),
      StatisticsPage(events: _events),
    ];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.add_circle_outline), selectedIcon: Icon(Icons.add_circle), label: 'Add'),
          NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: 'Statistics'),
        ],
      ),
    );
  }
}
