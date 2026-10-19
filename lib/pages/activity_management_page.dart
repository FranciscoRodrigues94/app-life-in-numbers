
import 'package:flutter/material.dart';
import '../models/life_activity.dart';
import '../services/activity_repository.dart';

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

  static const categories = {
    'consumption': 'Consumption',
    'experiences': 'Experiences',
    'hobbies': 'Hobbies',
    'activity': 'Activity',
    'social': 'Social',
    'fitness': 'Fitness',
    'other': 'Other',
  };

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
      _showMessage('Unable to load activities.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
      _showMessage(isNew ? 'Activity created.' : 'Activity updated.');
    } catch (error) {
      if (!mounted) return;
      _showMessage('Unable to save activity.');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _openEditor([LifeActivity? activity]) async {
    final controller = TextEditingController(text: activity?.name ?? '');
    String categoryId = categories.containsKey(activity?.categoryId)
        ? activity!.categoryId
        : 'other';

    final result = await showDialog<({String name, String categoryId})>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, updateDialog) {
            return AlertDialog(
              title: Text(activity == null ? 'New activity' : 'Edit activity'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    autofocus: true,
                    maxLength: 40,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Activity name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: categoryId,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    items: categories.entries.map((entry) {
                      return DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        updateDialog(() => categoryId = value);
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    final name = controller.text.trim();
                    if (name.isEmpty) return;
                    Navigator.pop(dialogContext, (name: name, categoryId: categoryId));
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    controller.dispose();
    if (result == null || !mounted) return;

    final updatedActivity = activity == null
        ? LifeActivity(
            id: 'custom_${DateTime.now().microsecondsSinceEpoch}',
            name: result.name,
            categoryId: result.categoryId,
            iconName: 'category',
          )
        : activity.copyWith(
            name: result.name,
            categoryId: result.categoryId,
          );

    await _saveActivity(updatedActivity, isNew: activity == null);
  }

  Future<void> _toggleActivity(LifeActivity activity, bool enabled) async {
    await _saveActivity(activity.copyWith(isActive: enabled), isNew: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage activities')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isSaving ? null : () => _openEditor(),
        icon: const Icon(Icons.add),
        label: const Text('New activity'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Choose what you want to track. Disabled activities keep their history.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 12),
                ..._activities.map((activity) {
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        activity.isActive ? Icons.check_circle_outline : Icons.hide_source_outlined,
                        color: activity.isActive ? const Color(0xFF0D9488) : Colors.grey,
                      ),
                      title: Text(activity.name),
                      subtitle: Text(categories[activity.categoryId] ?? activity.categoryId),
                      onTap: _isSaving ? null : () => _openEditor(activity),
                      trailing: Switch(
                        value: activity.isActive,
                        onChanged: _isSaving ? null : (value) => _toggleActivity(activity, value),
                      ),
                    ),
                  );
                }),
              ],
            ),
    );
  }
}
