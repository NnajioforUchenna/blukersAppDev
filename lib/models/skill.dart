class Skill {
  final String id;
  final String name;
  final String description;

  Skill({
    required this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  static Skill fromMap(Map<String, dynamic> map) {
    return Skill(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }

  @override
  String toString() {
    return '''Skill(
      id: $id,
      name: $name,
      description: $description,
    )''';
  }
}
