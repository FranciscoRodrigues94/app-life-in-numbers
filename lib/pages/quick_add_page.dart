
import 'package:flutter/material.dart';
import 'package:life_in_numbers/l10n/app_localizations.dart';
import '../core/theme/app_theme.dart';
import '../models/life_activity.dart';
import '../models/life_category.dart';
import '../services/display_name_service.dart';

class QuickAddPage extends StatefulWidget {
  final List<LifeActivity> activities;
  final List<LifeCategory> categories;
  final Map<String, int> records;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;
  final VoidCallback onManage;

  const QuickAddPage({
    super.key,
    required this.activities,
    required this.categories,
    required this.records,
    required this.onAdd,
    required this.onRemove,
    required this.onManage,
  });

  @override
  State<QuickAddPage> createState() => _QuickAddPageState();
}

class _QuickAddPageState extends State<QuickAddPage> {
  String _searchQuery = '';
  String? _selectedCategoryId;

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
    'meditation': Icons.self_improvement_rounded,
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
    final l10n = AppLocalizations.of(context)!;
    final availableCategories = widget.categories
        .where((category) => category.isActive)
        .toList();

    final selectedCategoryId = availableCategories.any(
      (category) => category.id == _selectedCategoryId,
    )
        ? _selectedCategoryId
        : null;

    final filteredActivities = widget.activities.where((activity) {
      if (!activity.isActive) return false;

      final displayName = DisplayNameService.activity(activity, l10n);
      final matchesSearch =
          displayName.toLowerCase().contains(_searchQuery) ||
          activity.name.toLowerCase().contains(_searchQuery);
      final matchesCategory = selectedCategoryId == null ||
          activity.categoryId == selectedCategoryId;

      return matchesSearch && matchesCategory;
    }).toList();

    final hasActiveActivities = widget.activities.any(
      (activity) => activity.isActive,
    );

    return ListView(
      key: const Key('quick_add_page'),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final mascotSize = constraints.maxWidth < 360 ? 96.0 : 128.0;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        l10n.addMomentTitle,
                        style: AppTypography.section.copyWith(
                          fontSize: 39,
                          height: 1.05,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.addMomentSubtitle,
                        style: AppTypography.body.copyWith(
                          color: AppColors.mutedText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset(
                  'assets/mascot/mascot_writing.png',
                  width: mascotSize,
                  height: mascotSize,
                  fit: BoxFit.contain,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 28),
        TextField(
          key: const Key('activity_search'),
          onChanged: (value) {
            setState(() {
              _searchQuery = value.trim().toLowerCase();
            });
          },
          style: AppTypography.body,
          decoration: InputDecoration(
            hintText: l10n.addSearchHint,
            hintStyle: AppTypography.body.copyWith(
              color: AppColors.mutedText,
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: AppColors.mutedText,
            ),
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 17,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _categoryChip(
                label: l10n.addAllCategories,
                selected: selectedCategoryId == null,
                onTap: () {
                  setState(() => _selectedCategoryId = null);
                },
                key: const Key('category_all'),
              ),
              for (final category in availableCategories) ...[
                const SizedBox(width: 8),
                _categoryChip(
                  label: DisplayNameService.category(category, l10n),
                  selected: selectedCategoryId == category.id,
                  onTap: () {
                    setState(() => _selectedCategoryId = category.id);
                  },
                  key: Key('category_${category.id}'),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 30),
        Text(
          l10n.dashboardYourActivities,
          style: AppTypography.section.copyWith(fontSize: 25),
        ),
        const SizedBox(height: 5),
        Text(
          l10n.addActivityCount(filteredActivities.length),
          style: AppTypography.caption,
        ),
        const SizedBox(height: 18),
        if (filteredActivities.isEmpty)
          _emptyState(hasActiveActivities)
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
                  for (var index = 0;
                      index < filteredActivities.length;
                      index++)
                    SizedBox(
                      width: cardWidth,
                      child: _activityCard(
                        activity: filteredActivities[index],
                        count: widget.records[
                                filteredActivities[index].id] ??
                            0,
                        background:
                            _tileColors[index % _tileColors.length],
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
                color: AppColors.sage,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  l10n.addClosingMessage,
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

  Widget _categoryChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    required Key key,
  }) {
    return Material(
      color: selected ? AppColors.navy : AppColors.surface,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        key: key,
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 17,
            vertical: 11,
          ),
          child: Text(
            label,
            style: AppTypography.body.copyWith(
              color: selected ? Colors.white : AppColors.navy,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _activityCard({
    required LifeActivity activity,
    required int count,
    required Color background,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final displayName = DisplayNameService.activity(activity, l10n);
    final icon = _icons[activity.iconName] ?? Icons.category_rounded;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: Key('quick_add_${activity.id}'),
        onTap: () => widget.onAdd(activity.id),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 12, 10),
          child: SizedBox(
            height: 126,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: AppColors.navy,
                      size: 30,
                    ),
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
                  displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.dashboardRecorded(count),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.navy.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                    if (count > 0)
                      IconButton(
                        key: Key('remove_activity_${activity.id}'),
                        tooltip: AppLocalizations.of(context)!.dashboardManageMoments,
                        onPressed: () => widget.onRemove(activity.id),
                        icon: const Icon(Icons.remove_rounded),
                        iconSize: 18,
                        color: AppColors.navy.withValues(alpha: 0.65),
                        visualDensity: VisualDensity.compact,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor:
                              Colors.white.withValues(alpha: 0.65),
                        ),
                      )
                    else
                      const SizedBox(width: 40, height: 40),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emptyState(bool hasActiveActivities) {
    return Container(
      key: const Key('quick_add_empty_state'),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 34,
            color: AppColors.accent,
          ),
          const SizedBox(height: 12),
          Text(
            hasActiveActivities
                ? AppLocalizations.of(context)!.addNothingFound
                : AppLocalizations.of(context)!.addStoryStartsHere,
            style: AppTypography.hero.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            hasActiveActivities
                ? AppLocalizations.of(context)!.addTryAnotherSearch
                : AppLocalizations.of(context)!.addNoActivitiesAvailable,
            style: AppTypography.body.copyWith(
              color: AppColors.mutedText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
