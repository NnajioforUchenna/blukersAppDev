class Address {
  final String? street; // street is now nullable
  final String? city; // city is now nullable
  final String? state; // state is now nullable
  final String? postalCode; // postalCode is now nullable
  final String? country; // country is now nullable

  Address({
    this.street = '', // street is now optional
    this.city = '', // city is now optional
    this.state = '', // state is now optional
    this.postalCode = '', // postalCode is now optional
    this.country = '', // country is now optional
  });

  get location => '$city, $state, $country';

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
    try {
      return Address(
        street: map['street'] as String?, // cast as String but keep it nullable
        city: map['city'] as String?, // cast as String but keep it nullable
        state: map['state'] as String?, // cast as String but keep it nullable
        postalCode:
            map['postalCode'] as String?, // cast as String but keep it nullable
        country:
            map['country'] as String?, // cast as String but keep it nullable
      );
    } catch (e) {
      // Handle the exception, e.g., logging or returning a default value
      print('An error occurred while creating Address from Map: $e');
      // Returning a default Address object or null, depending on your class design.
      return Address(
          street: '', city: '', state: '', postalCode: '', country: '');
    }
  }

  String displayAddress() {
    return [
      if (street != null && street!.isNotEmpty) street,
      if (city != null && city!.isNotEmpty) city,
      if (state != null && state!.isNotEmpty) state,
      if (postalCode != null && postalCode!.isNotEmpty) postalCode,
      if (country != null && country!.isNotEmpty) country,
    ].join(', ');
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
