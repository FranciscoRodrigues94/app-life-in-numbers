
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  final Map<String, int> records;

  const StatisticsPage({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    final total = records.values.fold<int>(0, (sum, value) => sum + value);
    final sortedRecords = records.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 12),
        const Text('Statistics', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Discover your life through numbers.', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 28),
        Card(
          elevation: 0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total recorded moments', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Text('$total', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),
        const Text('Activity breakdown', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        if (sortedRecords.isEmpty)
          const Card(
            elevation: 0,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text('No statistics yet. Add your first activity to get started.', textAlign: TextAlign.center),
            ),
          )
        else
          ...sortedRecords.map((entry) {
            final percentage = total == 0 ? 0.0 : entry.value / total;
            return Card(
              elevation: 0,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w600)),
                        Text('${entry.value} (${(percentage * 100).toStringAsFixed(1)}%)'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: percentage,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(8),
                      backgroundColor: const Color(0xFFE2E8F0),
                      color: const Color(0xFF0D9488),
                    ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }
}
