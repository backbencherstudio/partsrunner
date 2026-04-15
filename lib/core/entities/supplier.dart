class Supplier {
  String? id;
  String? name;
  String? location;
  String? street;
  String? city;
  String? zipCode;

  Supplier(
      {this.id,
      this.name,
      this.location,
      this.street,
      this.city,
      this.zipCode});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    street = json['street'];
    city = json['city'];
    zipCode = json['zip_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['location'] = location;
    data['street'] = street;
    data['city'] = city;
    data['zip_code'] = zipCode;
    return data;
  }
}