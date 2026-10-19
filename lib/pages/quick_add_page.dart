
import 'package:flutter/material.dart';

class QuickAddPage extends StatelessWidget {
  final Map<String, int> records;
  final ValueChanged<String> onAdd;

  const QuickAddPage({
    super.key,
    required this.records,
    required this.onAdd,
  });

  static const List<({String name, IconData icon})> activities = [
    (name: 'Coffee', icon: Icons.coffee_outlined),
    (name: 'Restaurant', icon: Icons.restaurant_outlined),
    (name: 'Cinema', icon: Icons.movie_outlined),
    (name: 'Reading', icon: Icons.menu_book_outlined),
    (name: 'Gaming', icon: Icons.sports_esports_outlined),
    (name: 'Walking', icon: Icons.directions_walk_outlined),
    (name: 'Shopping', icon: Icons.shopping_bag_outlined),
    (name: 'Social', icon: Icons.people_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 12),
        const Text(
          'Quick Add',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Capture a moment with a single tap.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 28),
        const Text(
          'Your activities',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 150,
          ),
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index];
            final count = records[activity.name] ?? 0;

            return Card(
              elevation: 0,
              color: Colors.white,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => onAdd(activity.name),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        activity.icon,
                        size: 30,
                        color: const Color(0xFF0D9488),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        activity.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$count recorded',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        const Text(
          'Custom activities will be available in a future update.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
