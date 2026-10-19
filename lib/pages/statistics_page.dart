
import 'package:flutter/material.dart';
import '../models/life_activity.dart';
import '../models/life_event.dart';
import '../services/statistics_service.dart';

class StatisticsPage extends StatelessWidget {
  final List<LifeEvent> events;
  final List<LifeActivity> activities;

  const StatisticsPage({super.key, required this.events, required this.activities});

  String _activityName(String activityId) {
    for (final activity in activities) {
      if (activity.id == activityId) return activity.name;
    }
    return activityId;
  }

  @override
  Widget build(BuildContext context) {
    const statistics = StatisticsService();
    final now = DateTime.now();
    final total = statistics.totalEvents(events);
    final today = statistics.totalToday(events, now: now);
    final thisMonth = statistics.totalThisMonth(events, now: now);
    final dailyAverage = statistics.averageLastDays(events, 7, now: now);
    final activityCounts = statistics.eventsByActivity(events);
    final sortedActivities = activityCounts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 12),
        const Text('Statistics', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Discover your life through numbers.', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 28),
        const Text('Your overview', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _statCard('Total records', '$total', Icons.numbers),
            _statCard('Today', '$today', Icons.today_outlined),
            _statCard('This month', '$thisMonth', Icons.calendar_month_outlined),
            _statCard('Daily average (7d)', dailyAverage.toStringAsFixed(2), Icons.trending_up),
          ],
        ),
        const SizedBox(height: 28),
        const Text('Activity breakdown', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        if (sortedActivities.isEmpty)
          const Card(
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text('No statistics yet. Add your first activity to get started.', textAlign: TextAlign.center),
            ),
          )
        else
          ...sortedActivities.map((entry) {
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
                      children: [
                        Expanded(child: Text(_activityName(entry.key), style: const TextStyle(fontWeight: FontWeight.w600))),
                        const SizedBox(width: 8),
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

  Widget _statCard(String title, String value, IconData icon) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF0D9488), size: 24),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
