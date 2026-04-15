class User {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? countryCode;

  User({this.id, this.name, this.email, this.phoneNumber, this.countryCode});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['country_code'] = this.countryCode;
    return data;
  }
}
