import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../models/life_activity.dart';
import '../models/life_event.dart';

class DashboardPage extends StatelessWidget {
  final Map<String, int> records;
  final List<LifeActivity> activities;
  final List<LifeEvent> events;
  final ValueChanged<String> onAdd;
  final VoidCallback onShowAll;

  const DashboardPage({
    super.key,
    required this.records,
    required this.activities,
    required this.events,
    required this.onAdd,
    required this.onShowAll,
  });

  static const Map<String, IconData> _icons = {
    'coffee': Icons.coffee_rounded,
    'restaurant': Icons.restaurant_rounded,
    'movie': Icons.movie_rounded,
    'book': Icons.menu_book_rounded,
    'gaming': Icons.sports_esports_rounded,
    'walking': Icons.directions_walk_rounded,
    'shopping': Icons.shopping_bag_rounded,
    'people': Icons.people_rounded,
    'fitness': Icons.fitness_center_rounded,
  };

  static const List<Color> _tileColors = [
    AppColors.sage,
    AppColors.sky,
    AppColors.peach,
    AppColors.sand,
  ];

  String _activityName(String id) {
    for (final activity in activities) {
      if (activity.id == id) return activity.name;
    }
    return id;
  }

  String _greeting(int hour) {
    if (hour < 12) return 'Good morning.';
    if (hour < 18) return 'Good afternoon.';
    return 'Good evening.';
  }

  String _monthName(int month) {
    const names = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return names[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final monthEvents = events.where((event) {
      return event.occurredAt.year == now.year &&
          event.occurredAt.month == now.month;
    }).toList();

    final totalRecords = events.length;
    final monthRecords = monthEvents.length;
    final trackedActivities = records.values.where((count) => count > 0).length;
    final activeActivities = activities
        .where((activity) => activity.isActive)
        .take(6)
        .toList();

    final monthlyCounts = <String, int>{};
    for (final event in monthEvents) {
      monthlyCounts[event.activityId] =
          (monthlyCounts[event.activityId] ?? 0) + 1;
    }

    MapEntry<String, int>? topMonthlyActivity;
    if (monthlyCounts.isNotEmpty) {
      topMonthlyActivity = monthlyCounts.entries.reduce(
        (a, b) => a.value >= b.value ? a : b,
      );
    }

    final highlight = topMonthlyActivity == null
        ? 'Your next moment is waiting to be recorded.'
        : '${_activityName(topMonthlyActivity.key)} is your most recorded activity this month, with ${topMonthlyActivity.value} moments.';

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LIFE IN NUMBERS',
                    style: AppTypography.caption.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.5,
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _greeting(now.hour),
                    key: const Key('dashboard_greeting'),
                    style: AppTypography.hero.copyWith(fontSize: 36),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your moments. Your story.',
                    style: AppTypography.body.copyWith(
                      color: AppColors.mutedText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Material(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.auto_awesome_rounded, color: AppColors.navy),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Container(
          key: const Key('dashboard_monthly_card'),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.navy,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_monthName(now.month).toUpperCase()} ${now.year}',
                style: AppTypography.caption.copyWith(
                  color: const Color(0xFFB6CBDB),
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                '$monthRecords',
                style: AppTypography.hero.copyWith(
                  fontSize: 66,
                  color: Colors.white,
                  height: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                monthRecords == 1 ? 'moment recorded' : 'moments recorded',
                style: AppTypography.body.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Container(height: 1, color: Colors.white.withValues(alpha: 0.18)),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _heroMetric('$totalRecords', 'All-time moments'),
                  ),
                  Expanded(
                    child: _heroMetric(
                      '$trackedActivities',
                      'Activities tracked',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: Text('YOUR ACTIVITIES', style: AppTypography.section),
            ),
            TextButton(onPressed: onShowAll, child: const Text('See all')),
          ],
        ),
        const SizedBox(height: 6),
        Text('One tap. One more moment.', style: AppTypography.caption),
        const SizedBox(height: 16),
        if (activeActivities.isEmpty)
          _emptyActivities()
        else
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 580 ? 3 : 2;
              const spacing = 12.0;
              final width =
                  (constraints.maxWidth - spacing * (columns - 1)) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  for (var i = 0; i < activeActivities.length; i++)
                    SizedBox(
                      width: width,
                      child: _activityTile(
                        activeActivities[i],
                        _tileColors[i % _tileColors.length],
                      ),
                    ),
                ],
              );
            },
          ),
        const SizedBox(height: 32),
        Text('HIGHLIGHTS', style: AppTypography.section),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.sage,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: AppColors.navy,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A little discovery',
                      style: AppTypography.body.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      highlight,
                      style: AppTypography.body.copyWith(
                        color: AppColors.mutedText,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _heroMetric(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: AppTypography.hero.copyWith(fontSize: 25, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTypography.caption.copyWith(color: const Color(0xFFC4D1DC)),
        ),
      ],
    );
  }

  Widget _activityTile(LifeActivity activity, Color background) {
    final icon = _icons[activity.iconName] ?? Icons.category_rounded;
    final count = records[activity.id] ?? 0;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: Key('quick_add_${activity.id}'),
        onTap: () => onAdd(activity.id),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: SizedBox(
            height: 112,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: AppColors.navy, size: 29),
                const Spacer(),
                Text(
                  activity.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$count recorded',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.navy.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emptyActivities() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'No active activities yet. Tap See all to manage your activities.',
        style: AppTypography.body,
      ),
    );
  }
}
