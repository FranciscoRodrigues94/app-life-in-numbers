
class LifeCategory {
  final String id;
  final String name;
  final bool isActive;

  const LifeCategory({
    required this.id,
    required this.name,
    this.isActive = true,
  });

  LifeCategory copyWith({
    String? name,
    bool? isActive,
  }) {
    return LifeCategory(
      id: id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isActive': isActive,
    };
  }

  factory LifeCategory.fromJson(Map<String, dynamic> json) {
    return LifeCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      isActive: json['isActive'] as bool? ?? true,
    );
  }
}
