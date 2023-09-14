class Reference {
  final String name;
  final String phoneNumber;
  final String email;
  final String relationship;

  Reference({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.relationship,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'relationship': relationship,
    };
  }

  static Reference fromMap(Map<String, dynamic> map) {
    return Reference(
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      relationship: map['relationship'],
    );
  }
}
