
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final Map<String, int> records;

  const DashboardPage({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    final totalRecords = records.values.fold<int>(0, (sum, value) => sum + value);
    final activeCategories = records.values.where((value) => value > 0).length;
    final topActivity = records.isEmpty ? null : records.entries.reduce((a, b) => a.value >= b.value ? a : b);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 12),
        Text('LIFE IN NUMBERS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2, color: Theme.of(context).colorScheme.primary)),
        const SizedBox(height: 8),
        const Text('My Life', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('Your story, one number at a time.', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 30),
        const Text('Your overview', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: _statCard('Total records', '$totalRecords', Icons.numbers)),
            const SizedBox(width: 12),
            Expanded(child: _statCard('Activities', '$activeCategories', Icons.category_outlined)),
          ],
        ),
        const SizedBox(height: 12),
        _statCard('Most recorded activity', topActivity == null ? 'No data yet' : '${topActivity.key} (${topActivity.value})', Icons.emoji_events_outlined),
        const SizedBox(height: 30),
        const Text('Your story', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.auto_awesome, color: Theme.of(context).colorScheme.primary, size: 30),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    totalRecords == 0
                        ? 'Your story starts with your first record. Tap Add to begin.'
                        : 'You have recorded $totalRecords moments so far. Keep discovering your life in numbers!',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF0D9488), size: 24),
            const SizedBox(height: 14),
            Text(value, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
