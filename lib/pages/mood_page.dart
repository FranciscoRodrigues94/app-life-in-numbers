import 'package:flutter/material.dart';
import 'package:life_in_numbers/l10n/app_localizations.dart';

import '../controllers/mood_controller.dart';
import '../core/theme/app_theme.dart';
import '../models/default_emotions.dart';
import '../models/life_mood_entry.dart';

class MoodPage extends StatelessWidget {
  final MoodController controller;
  final void Function(String message, VoidCallback onUndo)? onShowNotice;

  const MoodPage({super.key, required this.controller, this.onShowNotice});

  static const Map<String, IconData> _icons = {
    'happiness': Icons.wb_sunny_rounded,
    'sadness': Icons.water_drop_rounded,
    'anger': Icons.local_fire_department_rounded,
    'fear': Icons.shield_outlined,
    'disgust': Icons.sentiment_dissatisfied_rounded,
    'surprise': Icons.auto_awesome_rounded,
  };

  static const Map<String, Color> _colors = {
    'happiness': Color(0xFFF5D98B),
    'sadness': Color(0xFFB8CFEA),
    'anger': Color(0xFFEDB5A8),
    'fear': Color(0xFFD7C4E8),
    'disgust': Color(0xFFC5D5AC),
    'surprise': Color(0xFFB6DDE0),
  };

  String _emotionName(BuildContext context, String id) {
    final l10n = AppLocalizations.of(context)!;
    switch (id) {
      case 'joy': return l10n.dashboardEmotionJoy;
      case 'happiness': return l10n.dashboardEmotionHappiness;
      case 'sadness': return l10n.dashboardEmotionSadness;
      case 'anger': return l10n.dashboardEmotionAnger;
      case 'fear': return l10n.dashboardEmotionFear;
      case 'disgust': return l10n.dashboardEmotionDisgust;
      case 'surprise': return l10n.dashboardEmotionSurprise;
      default: return DefaultEmotions.primary.where((item) => item.id == id).map((item) => item.name).firstOrNull ?? id;
    }
  }

  void _addFeeling(BuildContext context, String emotionId) {
    if (controller.isLoading || controller.error != null) return;

    final entry = controller.addFeeling(emotionId);
    final l10n = AppLocalizations.of(context)!;
    final emotionName = _emotionName(context, emotionId);

    if (onShowNotice != null) {
      onShowNotice!(l10n.moodFeelingRecorded(emotionName), () {
        controller.removeFeeling(entry.id);
      });
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(l10n.moodFeelingRecorded(emotionName)),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: l10n.moodUndo,
            onPressed: () => controller.removeFeeling(entry.id),
          ),
        ),
      );
  }

  Future<void> _deleteFeeling(BuildContext context, LifeMoodEntry entry) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.moodDeleteTitle),
        content: Text(l10n.moodDeleteDescription),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.moodCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.moodDelete),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      controller.removeFeeling(entry.id);
    }
  }

  String _formatDate(DateTime date) {
    final local = date.toLocal();
    final day = local.day.toString().padLeft(2, '0');
    final month = local.month.toString().padLeft(2, '0');
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '$day/$month/${local.year} · $hour:$minute';
  }

  Widget _emotionCard(
    BuildContext context,
    LifeEmotion emotion,
    double width,
    int count,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      width: width,
      child: Material(
        color: _colors[emotion.id] ?? AppColors.sage,
        borderRadius: BorderRadius.circular(22),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: Key('mood_${emotion.id}'),
          onTap: () => _addFeeling(context, emotion.id),
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
                        _icons[emotion.id] ?? Icons.favorite_rounded,
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
                    _emotionName(context, emotion.id),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.navy,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    l10n.moodRecordedCount(count),
                    style: AppTypography.caption.copyWith(
                      color: AppColors.navy.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _historyItem(BuildContext context, LifeMoodEntry entry) {
    final emotion = DefaultEmotions.primary
        .where((item) => item.id == entry.primaryEmotionId)
        .firstOrNull;
    final name = _emotionName(context, emotion?.id ?? entry.primaryEmotionId);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: _colors[entry.primaryEmotionId] ?? AppColors.sage,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                _icons[entry.primaryEmotionId] ?? Icons.favorite_rounded,
                color: AppColors.navy,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _formatDate(entry.occurredAt),
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
            IconButton(
              key: Key('delete_feeling_${entry.id}'),
              tooltip: l10n.moodDeleteTooltip,
              onPressed: () => _deleteFeeling(context, entry),
              icon: const Icon(Icons.delete_outline_rounded),
              color: AppColors.mutedText,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final entries = List<LifeMoodEntry>.of(controller.entries)
          ..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));

        return ListView(
          key: const Key('mood_page'),
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
              l10n.moodTitle,
              style: AppTypography.section.copyWith(fontSize: 39, height: 1.05),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.moodSubtitle,
              style: AppTypography.body.copyWith(color: AppColors.mutedText),
            ),
            const SizedBox(height: 28),
            if (controller.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (controller.error != null)
              Text(
                controller.error!,
                style: AppTypography.body.copyWith(color: Colors.red.shade700),
              )
            else ...[
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 580 ? 3 : 2;
                  const spacing = 12.0;
                  final cardWidth =
                      (constraints.maxWidth - spacing * (columns - 1)) /
                      columns;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      for (final emotion in DefaultEmotions.primary)
                        _emotionCard(
                          context,
                          emotion,
                          cardWidth,
                          controller.emotionCounts[emotion.id] ?? 0,
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 12),
              Text(
                l10n.moodTapHint,
                style: AppTypography.caption,
                textAlign: TextAlign.center,
              ),
              if (controller.saveError != null) ...[
                const SizedBox(height: 16),
                Text(
                  controller.saveError!,
                  style: AppTypography.body.copyWith(
                    color: Colors.red.shade700,
                  ),
                ),
              ],
              const SizedBox(height: 38),
              Text(
                l10n.dashboardYourFeelings,
                style: AppTypography.section.copyWith(fontSize: 25),
              ),
              const SizedBox(height: 5),
              Text(
                l10n.moodHistoryCount(entries.length),
                style: AppTypography.caption,
              ),
              const SizedBox(height: 18),
              if (entries.isEmpty)
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.favorite_border_rounded,
                        size: 34,
                        color: AppColors.accent,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.moodEmptyTitle,
                        style: AppTypography.body.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.moodEmptyDescription,
                        style: AppTypography.caption,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                for (final entry in entries) _historyItem(context, entry),
            ],
          ],
        );
      },
    );
  }
}
