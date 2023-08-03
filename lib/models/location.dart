class Location {
  final String city;
  final String state;
  final String country;

  Location({
    required this.city,
    required this.state,
    required this.country,
  });

  // Convert Location to a Map
  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'state': state,
      'country': country,
    };
  }

  // Create a Location from a Map
  static Location fromMap(Map<String, dynamic> map) {
    return Location(
      city: map['city'],
      state: map['state'],
      country: map['country'],
    );
  }

  @override
  String toString() {
    return 'Location(city: $city, state: $state, country: $country)';
  }
}
