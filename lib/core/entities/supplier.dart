class Supplier {
  String? id;
  String? name;
  String? city;
  String? street;

  Supplier({this.id, this.name, this.city, this.street});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['city'] = city;
    data['street'] = street;
    return data;
  }
}
