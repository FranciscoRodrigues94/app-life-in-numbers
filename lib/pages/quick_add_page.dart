
import 'package:flutter/material.dart';
import '../models/life_activity.dart';

class QuickAddPage extends StatelessWidget {
  final List<LifeActivity> activities;
  final Map<String, int> records;
  final ValueChanged<String> onAdd;

  const QuickAddPage({
    super.key,
    required this.activities,
    required this.records,
    required this.onAdd,
  });

  static const Map<String, IconData> _icons = {
    'coffee': Icons.coffee_outlined,
    'restaurant': Icons.restaurant_outlined,
    'movie': Icons.movie_outlined,
    'book': Icons.menu_book_outlined,
    'gaming': Icons.sports_esports_outlined,
    'walking': Icons.directions_walk_outlined,
    'shopping': Icons.shopping_bag_outlined,
    'people': Icons.people_outline,
    'fitness': Icons.fitness_center_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final activeActivities = activities.where((activity) => activity.isActive).toList();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 12),
        const Text('Quick Add', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Capture a moment with a single tap.', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 28),
        const Text('Your activities', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        if (activeActivities.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text('No active activities available.', textAlign: TextAlign.center),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 150,
            ),
            itemCount: activeActivities.length,
            itemBuilder: (context, index) {
              final activity = activeActivities[index];
              final count = records[activity.id] ?? 0;
              final icon = _icons[activity.iconName] ?? Icons.category_outlined;

              return Card(
                elevation: 0,
                color: Colors.white,
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => onAdd(activity.id),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, size: 30, color: const Color(0xFF0D9488)),
                        const SizedBox(height: 8),
                        Text(
                          activity.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$count recorded',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
