class Brewery {
  Brewery(
      {required this.id,
      required this.name,
      this.city,
      this.state,
      this.postalCode,
      this.phoneNumber});

  final String id;
  final String name;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? phoneNumber;

  factory Brewery.fromJson(Map<String, dynamic> map) => Brewery(
      id: map['id'],
      name: map['name'],
      city: map['city'],
      state: map['state'],
      postalCode: map['postal_code'],
      phoneNumber: map['phone']);
}
