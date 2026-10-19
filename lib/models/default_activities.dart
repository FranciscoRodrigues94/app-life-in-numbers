
import 'life_activity.dart';

class DefaultActivities {
  static const List<LifeActivity> all = [
    LifeActivity(id: 'coffee', name: 'Coffee', categoryId: 'consumption', iconName: 'coffee'),
    LifeActivity(id: 'restaurant', name: 'Restaurant', categoryId: 'experiences', iconName: 'restaurant'),
    LifeActivity(id: 'cinema', name: 'Cinema', categoryId: 'experiences', iconName: 'movie'),
    LifeActivity(id: 'reading', name: 'Reading', categoryId: 'hobbies', iconName: 'book'),
    LifeActivity(id: 'gaming', name: 'Gaming', categoryId: 'hobbies', iconName: 'gaming'),
    LifeActivity(id: 'walking', name: 'Walking', categoryId: 'activity', iconName: 'walking'),
    LifeActivity(id: 'shopping', name: 'Shopping', categoryId: 'consumption', iconName: 'shopping'),
    LifeActivity(id: 'social', name: 'Social', categoryId: 'social', iconName: 'people'),
  ];
}
