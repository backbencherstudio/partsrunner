import 'package:partsrunner/core/entities/user.dart';

class Runner {
  String? id;
  String? vehicleType;
  String? vehicleModel;
  User? user;

  Runner({this.id, this.vehicleType, this.vehicleModel, this.user});

  Runner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleType = json['vehicle_type'];
    vehicleModel = json['vehicle_model'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vehicle_type'] = vehicleType;
    data['vehicle_model'] = vehicleModel;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
