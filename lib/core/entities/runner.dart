class Runner {
  final String id;
  final String vehicleType;
  final String vehicleModel;

  Runner({
    required this.id,
    required this.vehicleType,
    required this.vehicleModel,
  });

  factory Runner.fromJson(Map<String, dynamic> json) {
    return Runner(
      id: json['id'],
      vehicleType: json['vehicle_type'],
      vehicleModel: json['vehicle_model'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicle_type': vehicleType,
      'vehicle_model': vehicleModel,
    };
  }
}
