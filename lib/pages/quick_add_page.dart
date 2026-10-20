import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../models/life_activity.dart';

class QuickAddPage extends StatelessWidget {
  final List<LifeActivity> activities;
  final Map<String, int> records;
  final ValueChanged<String> onAdd;
  final VoidCallback onManage;

  const QuickAddPage({
    super.key,
    required this.activities,
    required this.records,
    required this.onAdd,
    required this.onManage,
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
    'category': Icons.category_rounded,
  };

  static const List<Color> _tileColors = [
    AppColors.sage,
    AppColors.sky,
    AppColors.peach,
    AppColors.sand,
  ];

  @override
  Widget build(BuildContext context) {
    final activeActivities = activities
        .where((activity) => activity.isActive)
        .toList();

    return ListView(
      key: const Key('quick_add_page'),
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
          'ADD A MOMENT',
          style: AppTypography.section.copyWith(fontSize: 39, height: 1.05),
        ),
        const SizedBox(height: 8),
        Text(
          'A little moment. A bigger picture.',
          style: AppTypography.body.copyWith(color: AppColors.mutedText),
        ),
        const SizedBox(height: 28),
        Row(
          children: [
            Expanded(
              child: Text(
                'YOUR ACTIVITIES',
                style: AppTypography.section.copyWith(fontSize: 25),
              ),
            ),
            TextButton.icon(
              key: const Key('manage_activities_button'),
              onPressed: onManage,
              icon: const Icon(Icons.tune_rounded, size: 18),
              label: const Text('Manage'),
              style: TextButton.styleFrom(foregroundColor: AppColors.navy),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          'Tap any activity to record it instantly.',
          style: AppTypography.caption,
        ),
        const SizedBox(height: 18),
        if (activeActivities.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.add_circle_outline_rounded,
                  size: 36,
                  color: AppColors.accent,
                ),
                const SizedBox(height: 14),
                Text(
                  'Your story starts here.',
                  style: AppTypography.hero.copyWith(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Create or activate an activity to start recording your moments.',
                  style: AppTypography.body.copyWith(
                    color: AppColors.mutedText,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: onManage,
                  icon: const Icon(Icons.add),
                  label: const Text('Manage activities'),
                ),
              ],
            ),
          )
        else
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 580 ? 3 : 2;
              const spacing = 12.0;
              final cardWidth =
                  (constraints.maxWidth - spacing * (columns - 1)) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  for (var index = 0; index < activeActivities.length; index++)
                    SizedBox(
                      width: cardWidth,
                      child: _activityCard(
                        activity: activeActivities[index],
                        count: records[activeActivities[index].id] ?? 0,
                        background: _tileColors[index % _tileColors.length],
                      ),
                    ),
                ],
              );
            },
          ),
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.auto_awesome_rounded,
                size: 27,
                color: Color(0xFFDDECE0),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  'Every little moment adds to your story.',
                  style: AppTypography.body.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _activityCard({
    required LifeActivity activity,
    required int count,
    required Color background,
  }) {
    final icon = _icons[activity.iconName] ?? Icons.category_rounded;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: Key('quick_add_${activity.id}'),
        onTap: () => onAdd(activity.id),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: SizedBox(
            height: 126,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: AppColors.navy, size: 30),
                    const Spacer(),
                    Icon(
                      Icons.add_circle_outline_rounded,
                      color: AppColors.navy.withValues(alpha: 0.65),
                      size: 23,
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  activity.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
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
}
