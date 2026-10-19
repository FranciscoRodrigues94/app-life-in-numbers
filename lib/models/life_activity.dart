
class LifeActivity {
  final String id;
  final String name;
  final String categoryId;
  final String iconName;
  final String unit;
  final bool isActive;

  const LifeActivity({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.iconName,
    this.unit = 'count',
    this.isActive = true,
  });

  LifeActivity copyWith({
    String? name,
    String? categoryId,
    String? iconName,
    String? unit,
    bool? isActive,
  }) {
    return LifeActivity(
      id: id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      iconName: iconName ?? this.iconName,
      unit: unit ?? this.unit,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'iconName': iconName,
      'unit': unit,
      'isActive': isActive,
    };
  }

  factory LifeActivity.fromJson(Map<String, dynamic> json) {
    return LifeActivity(
      id: json['id'] as String,
      name: json['name'] as String,
      categoryId: json['categoryId'] as String,
      iconName: json['iconName'] as String,
      unit: json['unit'] as String? ?? 'count',
      isActive: json['isActive'] as bool? ?? true,
    );
  }
}
