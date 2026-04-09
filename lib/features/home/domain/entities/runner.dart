/// Runner Entity
class Runner {
  final String vehicleType;
  final String vehicleModel;

  Runner({required this.vehicleType, required this.vehicleModel});

  factory Runner.fromJson(Map<String, dynamic> json) {
    return Runner(
      vehicleType: json['vehicle_type'],
      vehicleModel: json['vehicle_model'],
    );
  }
}