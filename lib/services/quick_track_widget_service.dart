import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';

class QuickTrackWidgetService {
  static Future<void> _pendingUpdate = Future<void>.value();

  static void update({
    required List<String> momentIds,
    required List<String> momentNames,
    required List<String> feelingIds,
    required List<String> feelingNames,
  }) {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;

    _pendingUpdate = _pendingUpdate.then((_) async {
      try {
        final values = <String, String>{
          'moment_1_id': momentIds.isNotEmpty ? momentIds[0] : '',
          'moment_2_id': momentIds.length > 1 ? momentIds[1] : '',
          'feeling_1_id': feelingIds.isNotEmpty ? feelingIds[0] : '',
          'feeling_2_id': feelingIds.length > 1 ? feelingIds[1] : '',
          'moment_1_name': momentNames.isNotEmpty ? momentNames[0] : 'Moment',
          'moment_2_name': momentNames.length > 1 ? momentNames[1] : 'Moment',
          'feeling_1_name': feelingNames.isNotEmpty ? feelingNames[0] : 'Feeling',
          'feeling_2_name': feelingNames.length > 1 ? feelingNames[1] : 'Feeling',
        };

        for (final entry in values.entries) {
          await HomeWidget.saveWidgetData<String>(entry.key, entry.value);
        }

        await HomeWidget.updateWidget(
          androidName: 'QuickTrackWidgetProvider',
        );
      } catch (error) {
        debugPrint('Quick Track widget update failed: $error');
      }
    });
  }
}
