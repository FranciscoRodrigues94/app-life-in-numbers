
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../models/life_activity.dart';
import '../models/life_event.dart';
import '../services/statistics_service.dart';

class StatisticsPage extends StatelessWidget {
  final List<LifeEvent> events;
  final List<LifeActivity> activities;

  const StatisticsPage({
    super.key,
    required this.events,
    required this.activities,
  });

  static const List<Color> _chartColors = [
    AppColors.accent,
    Color(0xFF7296BD),
    Color(0xFFD79F86),
    Color(0xFFA59CBF),
    Color(0xFFB3A17C),
  ];

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
    final sortedActivities = activityCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final topActivity = sortedActivities.isEmpty ? null : sortedActivities.first;
    final topName = topActivity == null ? null : _activityName(topActivity.key);
    final topPercentage = total == 0 || topActivity == null
        ? 0.0
        : (topActivity.value / total) * 100;

    return ListView(
      key: const Key('statistics_page'),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      children: [
        Text(
          'LIFE IN NUMBERS',
          style: AppTypography.caption.copyWith(
            color: AppColors.accent,
            letterSpacing: 2.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'STATISTICS',
          style: AppTypography.section.copyWith(
            fontSize: 39,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your life, seen through numbers.',
          style: AppTypography.body.copyWith(
            color: AppColors.mutedText,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'Your life at a glance',
          style: AppTypography.hero.copyWith(fontSize: 27),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 12.0;
            final columns = constraints.maxWidth >= 650 ? 4 : 2;
            final width = (constraints.maxWidth - spacing * (columns - 1)) / columns;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                SizedBox(
                  width: width,
                  child: _metricCard(
                    key: const Key('statistics_total_card'),
                    label: 'ALL-TIME',
                    value: '$total',
                    description: 'Total moments',
                    icon: Icons.auto_awesome_rounded,
                    background: AppColors.navy,
                    dark: true,
                  ),
                ),
                SizedBox(
                  width: width,
                  child: _metricCard(
                    key: const Key('statistics_today_card'),
                    label: 'TODAY',
                    value: '$today',
                    description: 'Moments today',
                    icon: Icons.wb_sunny_outlined,
                    background: AppColors.sage,
                  ),
                ),
                SizedBox(
                  width: width,
                  child: _metricCard(
                    key: const Key('statistics_month_card'),
                    label: 'THIS MONTH',
                    value: '$thisMonth',
                    description: 'Moments recorded',
                    icon: Icons.calendar_today_outlined,
                    background: AppColors.sky,
                  ),
                ),
                SizedBox(
                  width: width,
                  child: _metricCard(
                    key: const Key('statistics_average_card'),
                    label: 'LAST 7 DAYS',
                    value: dailyAverage.toStringAsFixed(1),
                    description: 'Daily average',
                    icon: Icons.trending_up_rounded,
                    background: AppColors.peach,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 34),
        Row(
          children: [
            Expanded(
              child: Text(
                'ACTIVITY BREAKDOWN',
                style: AppTypography.section.copyWith(fontSize: 25),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'All time',
              style: AppTypography.caption,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'The moments you have recorded most.',
          style: AppTypography.caption,
        ),
        const SizedBox(height: 18),
        if (sortedActivities.isEmpty)
          _emptyState()
        else
          Container(
            key: const Key('statistics_breakdown'),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                for (var i = 0; i < sortedActivities.length; i++) ...[
                  _activityProgress(
                    activityId: sortedActivities[i].key,
                    count: sortedActivities[i].value,
                    total: total,
                    color: _chartColors[i % _chartColors.length],
                  ),
                  if (i < sortedActivities.length - 1)
                    const SizedBox(height: 22),
                ],
              ],
            ),
          ),
        const SizedBox(height: 34),
        Text(
          'HIGHLIGHTS',
          style: AppTypography.section.copyWith(fontSize: 25),
        ),
        const SizedBox(height: 14),
        Container(
          key: const Key('statistics_highlight'),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppColors.sand,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.auto_awesome_rounded,
                color: AppColors.navy,
                size: 27,
              ),
              const SizedBox(height: 18),
              Text(
                topName ?? 'Your story starts here.',
                style: AppTypography.hero.copyWith(
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                topActivity == null
                    ? 'Record your first moment to start discovering your personal statistics.'
                    : '${topActivity.value} recorded moments · ${topPercentage.toStringAsFixed(1)}% of all your records.',
                style: AppTypography.body.copyWith(
                  color: AppColors.mutedText,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _metricCard({
    required Key key,
    required String label,
    required String value,
    required String description,
    required IconData icon,
    required Color background,
    bool dark = false,
  }) {
    final foreground = dark ? Colors.white : AppColors.navy;
    final secondary = dark ? const Color(0xFFBBCAD8) : AppColors.mutedText;

    return Container(
      key: key,
      height: 168,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption.copyWith(
                    color: secondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.9,
                  ),
                ),
              ),
              Icon(icon, color: foreground, size: 19),
            ],
          ),
          const Spacer(),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: AppTypography.hero.copyWith(
                fontSize: 43,
                height: 1,
                color: foreground,
              ),
            ),
          ),
          const SizedBox(height: 9),
          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.caption.copyWith(
              color: secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityProgress({
    required String activityId,
    required int count,
    required int total,
    required Color color,
  }) {
    final percentage = total == 0 ? 0.0 : count / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                _activityName(activityId),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.body.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$count  ·  ${(percentage * 100).toStringAsFixed(1)}%',
              style: AppTypography.caption.copyWith(
                color: AppColors.navy,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 11),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 10,
            backgroundColor: const Color(0xFFEBEEF0),
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _emptyState() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Text(
        'No moments recorded yet. Add your first activity to see your statistics.',
        style: AppTypography.body.copyWith(
          color: AppColors.mutedText,
          height: 1.5,
        ),
      ),
    );
  }
}
