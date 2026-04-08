/// Supplier Entity
class Supplier {
  final String name;
  final String street;
  final String city;

  Supplier({required this.name, required this.street, required this.city});

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      name: json['name'],
      street: json['street'],
      city: json['city'],
    );
  }

  String get fullAddress => "$street, $city";
}
