import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../models/life_activity.dart';
import '../models/life_event.dart';
import '../models/life_mood_entry.dart';
import '../models/default_emotions.dart';
import '../services/did_you_know_service.dart';
import '../services/highlights_service.dart';

class DashboardPage extends StatefulWidget {
  final Map<String, int> records;
  final List<LifeActivity> activities;
  final List<LifeEvent> events;
  final List<LifeMoodEntry> feelings;
  final VoidCallback onShowMood;
  final ValueChanged<String> onAddFeeling;
  final String userName;
  final VoidCallback onEditName;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;
  final VoidCallback onShowAll;

  const DashboardPage({
    super.key,
    required this.records,
    required this.activities,
    required this.events,
    required this.feelings,
    required this.onShowMood,
    required this.onAddFeeling,
    required this.userName,
    required this.onEditName,
    required this.onAdd,
    required this.onRemove,
    required this.onShowAll,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _HighlightDisplay {
  final String title;
  final String message;
  final String label;
  final String? source;
  final bool isFact;

  const _HighlightDisplay({
    required this.title,
    required this.message,
    required this.label,
    this.source,
    this.isFact = false,
  });
}

class _DashboardPageState extends State<DashboardPage> {
  int _highlightIndex = 0;

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
  };

  static const Map<String, IconData> _emotionIcons = {
    'joy': Icons.wb_sunny_rounded,
    'happiness': Icons.wb_sunny_rounded,
    'sadness': Icons.water_drop_rounded,
    'anger': Icons.local_fire_department_rounded,
    'fear': Icons.shield_outlined,
    'disgust': Icons.sentiment_dissatisfied_rounded,
    'surprise': Icons.auto_awesome_rounded,
  };

  static const Map<String, Color> _emotionColors = {
    'joy': Color(0xFFF5D98B),
    'happiness': Color(0xFFF5D98B),
    'sadness': Color(0xFFB8CFEA),
    'anger': Color(0xFFEDB5A8),
    'fear': Color(0xFFD7C4E8),
    'disgust': Color(0xFFC5D5AC),
    'surprise': Color(0xFFB6DDE0),
  };

  static const List<Color> _tileColors = [
    AppColors.sage,
    AppColors.sky,
    AppColors.peach,
    AppColors.sand,
  ];

  String _greeting(int hour) {
    final period = hour < 12 ? 'Good morning' : hour < 18 ? 'Good afternoon' : 'Good evening';
    return widget.userName.trim().isEmpty ? '$period.' : '$period, ${widget.userName.trim()}.';
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

  List<_HighlightDisplay> _buildHighlights(DateTime now) {
    final statistics = HighlightsService().getHighlights(
      widget.events,
      widget.activities,
      now: now,
    );

    final facts = const DidYouKnowService().factsForEvents(widget.events);
    final results = <_HighlightDisplay>[];
    final maximum = statistics.length > facts.length
        ? statistics.length
        : facts.length;

    for (var i = 0; i < maximum; i++) {
      if (i < statistics.length) {
        final highlight = statistics[i];
        results.add(
          _HighlightDisplay(
            title: highlight.title,
            message: highlight.message,
            label: 'YOUR LIFE IN NUMBERS',
          ),
        );
      }

      if (i < facts.length) {
        final fact = facts[i];
        final activityName =
            widget.activities
                .where((activity) => activity.id == fact.activityId)
                .map((activity) => activity.name)
                .firstOrNull ??
            fact.activityId;

        results.add(
          _HighlightDisplay(
            title: fact.title,
            message: fact.message,
            label: 'DID YOU KNOW? · ${activityName.toUpperCase()}',
            source: fact.sourceName,
            isFact: true,
          ),
        );
      }
    }

    return results;
  }

  void _changeHighlight(int direction, int count) {
    if (count <= 1) return;
    setState(() {
      _highlightIndex = (_highlightIndex + direction + count) % count;
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final monthRecords = widget.events.where((event) {
      return event.occurredAt.year == now.year &&
          event.occurredAt.month == now.month;
    }).length;

    final monthFeelings = widget.feelings.where((entry) {
      final local = entry.occurredAt.toLocal();
      return local.year == now.year && local.month == now.month;
    }).length;
    final emotionCounts = <String, int>{};
    for (final entry in widget.feelings) {
      emotionCounts[entry.primaryEmotionId] =
          (emotionCounts[entry.primaryEmotionId] ?? 0) + 1;
    }
    final recordedEmotions = DefaultEmotions.primary
        .where((emotion) => (emotionCounts[emotion.id] ?? 0) > 0)
        .toList()
      ..sort((a, b) => (emotionCounts[b.id] ?? 0).compareTo(emotionCounts[a.id] ?? 0));

    final totalRecords = widget.events.length;
    final trackedActivities = widget.records.values
        .where((count) => count > 0)
        .length;

    final recordedActivities = widget.activities
        .where(
          (activity) =>
              activity.isActive && (widget.records[activity.id] ?? 0) > 0,
        )
        .toList()
      ..sort((a, b) => (widget.records[b.id] ?? 0).compareTo(widget.records[a.id] ?? 0));

    final highlights = _buildHighlights(now);
    final currentIndex = highlights.isEmpty
        ? 0
        : _highlightIndex % highlights.length;
    final currentHighlight = highlights.isEmpty ? null : highlights[currentIndex];

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
                  InkWell(
                    key: const Key('dashboard_edit_name'),
                    borderRadius: BorderRadius.circular(12),
                    onTap: widget.onEditName,
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            _greeting(now.hour),
                            key: const Key('dashboard_greeting'),
                            style: AppTypography.hero.copyWith(fontSize: 36),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.edit_outlined, size: 17, color: AppColors.mutedText),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your moments. Your feelings. Your story.',
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
            borderRadius: BorderRadius.circular(24),
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
                    child: _heroMetric('$trackedActivities', 'Activities tracked'),
                  ),
                  Expanded(
                    child: _heroMetric('$totalRecords', 'All-time moments'),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(height: 1, color: Colors.white.withValues(alpha: 0.18)),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(child: _heroMetric('$monthFeelings', 'Feelings this month')),
                  Expanded(child: _heroMetric('${widget.feelings.length}', 'All-time feelings')),
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
            TextButton(
              onPressed: widget.onShowAll,
              child: const Text('See all'),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text('One tap. One more moment.', style: AppTypography.caption),
        const SizedBox(height: 16),
        if (recordedActivities.isEmpty)
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
                  for (var i = 0; i < recordedActivities.length; i++)
                    SizedBox(
                      width: width,
                      child: _activityTile(
                        recordedActivities[i],
                        _tileColors[i % _tileColors.length],
                      ),
                    ),
                ],
              );
            },
          ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(child: Text('YOUR FEELINGS', style: AppTypography.section)),
            TextButton(onPressed: widget.onShowMood, child: const Text('See all')),
          ],
        ),
        const SizedBox(height: 6),
        Text('A little check-in with yourself.', style: AppTypography.caption),
        const SizedBox(height: 16),
        if (recordedEmotions.isEmpty)
          Container(
            key: const Key('dashboard_empty_feelings'),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.favorite_border_rounded, color: AppColors.accent),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'No feelings recorded yet. Tap See all to log your first feeling.',
                    style: AppTypography.body,
                  ),
                ),
              ],
            ),
          )
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
                  for (final emotion in recordedEmotions)
                    SizedBox(
                      width: width,
                      child: _feelingTile(
                        emotion,
                        emotionCounts[emotion.id] ?? 0,
                      ),
                    ),
                ],
              );
            },
          ),
        const SizedBox(height: 32),
        Text('HIGHLIGHTS', style: AppTypography.section),
        const SizedBox(height: 14),
        if (currentHighlight != null)
        Container(
          key: const Key('dashboard_highlight_card'),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: currentHighlight.isFact
                          ? AppColors.sky
                          : AppColors.sage,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      currentHighlight.isFact
                          ? Icons.lightbulb_outline_rounded
                          : Icons.auto_awesome_rounded,
                      color: AppColors.navy,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentHighlight.label,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.7,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentHighlight.title,
                          key: const Key('dashboard_highlight_title'),
                          style: AppTypography.body.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentHighlight.message,
                          key: const Key('dashboard_highlight_message'),
                          style: AppTypography.body.copyWith(
                            color: AppColors.mutedText,
                            height: 1.5,
                          ),
                        ),
                        if (currentHighlight.source != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            'Source: ${currentHighlight.source}',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.mutedText,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              if (highlights.length > 1) ...[
                const SizedBox(height: 20),
                Divider(
                  height: 1,
                  color: AppColors.navy.withValues(alpha: 0.10),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      key: const Key('highlight_previous'),
                      tooltip: 'Previous highlight',
                      onPressed: () => _changeHighlight(-1, highlights.length),
                      icon: const Icon(Icons.chevron_left_rounded),
                      color: AppColors.navy,
                    ),
                    Text(
                      '${currentIndex + 1} / ${highlights.length}',
                      key: const Key('highlight_page_indicator'),
                      style: AppTypography.caption.copyWith(
                        color: AppColors.mutedText,
                      ),
                    ),
                    IconButton(
                      key: const Key('highlight_next'),
                      tooltip: 'Next highlight',
                      onPressed: () => _changeHighlight(1, highlights.length),
                      icon: const Icon(Icons.chevron_right_rounded),
                      color: AppColors.navy,
                    ),
                  ],
                ),
              ],
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
    final count = widget.records[activity.id] ?? 0;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: Key('quick_add_${activity.id}'),
        onTap: () => widget.onAdd(activity.id),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 12, 10),
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '$count recorded',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.navy.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                    IconButton(
                      key: Key('remove_activity_${activity.id}'),
                      tooltip: 'Manage recorded moments',
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
                        backgroundColor: Colors.white.withValues(alpha: 0.65),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _feelingTile(LifeEmotion emotion, int count) {
    return Material(
      color: _emotionColors[emotion.id] ?? AppColors.sage,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: Key('dashboard_feeling_${emotion.id}'),
        onTap: () => widget.onAddFeeling(emotion.id),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 12, 10),
          child: SizedBox(
            height: 112,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  _emotionIcons[emotion.id] ?? Icons.favorite_rounded,
                  color: AppColors.navy,
                  size: 29,
                ),
                const Spacer(),
                Text(
                  emotion.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body.copyWith(
                    color: AppColors.navy,
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
        'No moments recorded yet. Tap See all to record your first activity.',
        style: AppTypography.body,
      ),
    );
  }
}
