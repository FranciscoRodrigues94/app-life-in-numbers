
import 'package:flutter/material.dart';
import 'pages/dashboard_page.dart';
import 'pages/quick_add_page.dart';
import 'pages/statistics_page.dart';

void main() {
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
  int _selectedIndex = 0;
  final Map<String, int> _records = {};

  void _addRecord(String activity) {
    setState(() {
      _records[activity] = (_records[activity] ?? 0) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(records: _records),
      QuickAddPage(records: _records, onAdd: _addRecord),
      StatisticsPage(records: _records),
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
