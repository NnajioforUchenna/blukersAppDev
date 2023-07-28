class Skill {
  final String id;
  final String? name; // name is now nullable
  final String? description; // description is now nullable

  Skill({
    required this.id,
    this.name, // name is now optional
    this.description, // description is now optional
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
      id: map['id'] ?? '', // provide a default value if 'id' is null
      name: map['name'] as String?, // cast as String but keep it nullable
      description:
          map['description'] as String?, // cast as String but keep it nullable
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
