class ReferenceForm {
  final String name;
  final String phoneNumber;
  final String email;
  final String relationship;

  ReferenceForm({
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

  static ReferenceForm fromMap(Map<String, dynamic> map) {
    return ReferenceForm(
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      relationship: map['relationship'],
    );
  }
}
