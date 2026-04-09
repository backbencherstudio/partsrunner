class Supplier {
  final String id;
  final String name;
  final String city;
  final String street;

  Supplier({
    required this.id,
    required this.name,
    required this.city,
    required this.street,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      street: json['street'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'street': street,
    };
  }
}
