class Address {
  final String? street; // street is now nullable
  final String? city; // city is now nullable
  final String? state; // state is now nullable
  final String? postalCode; // postalCode is now nullable
  final String? country; // country is now nullable

  Address({
    this.street, // street is now optional
    this.city, // city is now optional
    this.state, // state is now optional
    this.postalCode, // postalCode is now optional
    this.country, // country is now optional
  });

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
    };
  }

  static Address fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'] as String?, // cast as String but keep it nullable
      city: map['city'] as String?, // cast as String but keep it nullable
      state: map['state'] as String?, // cast as String but keep it nullable
      postalCode:
          map['postalCode'] as String?, // cast as String but keep it nullable
      country: map['country'] as String?, // cast as String but keep it nullable
    );
  }

  @override
  String toString() {
    return '''Address(
      street: $street,
      city: $city,
      state: $state,
      postalCode: $postalCode,
      country: $country,
    )''';
  }
}
