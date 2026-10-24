import 'package:flutter/material.dart';
import 'package:life_in_numbers/l10n/app_localizations.dart';
import '../models/life_activity.dart';
import '../models/life_category.dart';
import '../services/activity_repository.dart';
import '../services/display_name_service.dart';

class ActivityManagementPage extends StatefulWidget {
  final ActivityRepository repository;

  const ActivityManagementPage({super.key, required this.repository});

  @override
  State<ActivityManagementPage> createState() => _ActivityManagementPageState();
}

class _ActivityManagementPageState extends State<ActivityManagementPage> {
  List<LifeActivity> _activities = [];
  bool _isLoading = true;
  bool _isSaving = false;

  static const List<String> _categoryIds = [
    'consumption', 'experiences', 'hobbies', 'wellness', 'social', 'fitness',
  ];

  String _categoryName(String id, AppLocalizations l10n) {
    const names = {
      'consumption': 'Consumption',
      'experiences': 'Experiences',
      'hobbies': 'Hobbies',
      'wellness': 'Wellness',
      'social': 'Social',
      'fitness': 'Fitness',
    };
    final name = names[id];
    if (name == null) return id;
    return DisplayNameService.category(LifeCategory(id: id, name: name), l10n);
  }

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    try {
      final activities = await widget.repository.loadActivities();
      if (!mounted) return;
      setState(() {
        _activities = activities;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showMessage(AppLocalizations.of(context)!.manageLoadError);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _saveActivity(LifeActivity activity, {required bool isNew}) async {
    if (_isSaving) return;
    setState(() => _isSaving = true);
    try {
      if (isNew) {
        await widget.repository.addActivity(activity);
      } else {
        await widget.repository.updateActivity(activity);
      }
      await _loadActivities();
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      _showMessage(isNew ? l10n.manageCreated : l10n.manageUpdated);
    } catch (error) {
      if (!mounted) return;
      _showMessage(AppLocalizations.of(context)!.manageSaveError);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _openEditor([LifeActivity? activity]) async {
    final l10n = AppLocalizations.of(context)!;
    final displayName = activity == null ? '' : DisplayNameService.activity(activity, l10n);
    final controller = TextEditingController(text: displayName);
    final initialCategoryId = activity?.categoryId == 'welness' ? 'wellness' : activity?.categoryId;
    String categoryId = _categoryIds.contains(initialCategoryId) ? initialCategoryId! : 'consumption';

    final result = await showDialog<({String name, String categoryId})>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, updateDialog) {
            return AlertDialog(
              title: Text(activity == null ? l10n.manageNewActivity : l10n.manageEditActivity),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    autofocus: true,
                    maxLength: 40,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: l10n.manageActivityName,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: categoryId,
                    decoration: InputDecoration(
                      labelText: l10n.manageCategory,
                      border: const OutlineInputBorder(),
                    ),
                    items: _categoryIds.map((id) => DropdownMenuItem(
                      value: id,
                      child: Text(_categoryName(id, l10n)),
                    )).toList(),
                    onChanged: (value) {
                      if (value != null) updateDialog(() => categoryId = value);
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(l10n.manageCancel),
                ),
                FilledButton(
                  onPressed: () {
                    final name = controller.text.trim();
                    if (name.isEmpty) return;
                    Navigator.pop(dialogContext, (name: name, categoryId: categoryId));
                  },
                  child: Text(l10n.manageSave),
                ),
              ],
            );
          },
        );
      },
    );

    controller.dispose();
    if (result == null || !mounted) return;
    final savedName = activity != null && result.name == displayName ? activity.name : result.name;
    final updatedActivity = activity == null
        ? LifeActivity(
            id: 'custom_${DateTime.now().microsecondsSinceEpoch}',
            name: savedName,
            categoryId: result.categoryId,
            iconName: 'category',
          )
        : activity.copyWith(name: savedName, categoryId: result.categoryId);

    await _saveActivity(updatedActivity, isNew: activity == null);
  }

  Future<void> _toggleActivity(LifeActivity activity, bool enabled) async {
    await _saveActivity(activity.copyWith(isActive: enabled), isNew: false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.manageTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isSaving ? null : () => _openEditor(),
        icon: const Icon(Icons.add),
        label: Text(l10n.manageNewActivity),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(l10n.manageDescription, style: const TextStyle(color: Colors.grey)),
                ),
                const SizedBox(height: 12),
                ..._activities.map((activity) => Card(
                  child: ListTile(
                    leading: Icon(
                      activity.isActive ? Icons.check_circle_outline : Icons.hide_source_outlined,
                      color: activity.isActive ? const Color(0xFF0D9488) : Colors.grey,
                    ),
                    title: Text(DisplayNameService.activity(activity, l10n)),
                    subtitle: Text(_categoryName(activity.categoryId, l10n)),
                    onTap: _isSaving ? null : () => _openEditor(activity),
                    trailing: Switch(
                      value: activity.isActive,
                      onChanged: _isSaving ? null : (value) => _toggleActivity(activity, value),
                    ),
                  ),
                )),
              ],
            ),
    );
  }
}
