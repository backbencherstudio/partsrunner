import 'package:partsrunner/core/entities/user.dart';

class Contractor {
  String? id;
  String? companyName;
  String? businessAddress;
  User? user;

  Contractor({this.id, this.companyName, this.businessAddress, this.user});

  Contractor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    businessAddress = json['business_address'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['business_address'] = this.businessAddress;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}