import 'package:partsrunner/features/home/domain/entities/delivery_request_runner_entity.dart';

class DeliveryHomeRunnerModel {
  final bool isOnline;
  final double todayEarning;
  final int todayDeliveries;
  final List<DeliveryRequestRunnerEntity> requests;

  DeliveryHomeRunnerModel({
    required this.isOnline,
    required this.todayEarning,
    required this.todayDeliveries,
    required this.requests,
  });

  factory DeliveryHomeRunnerModel.fromJson(Map<String, dynamic> json) {
    return DeliveryHomeRunnerModel(
      isOnline: json['online_status'],
      todayEarning: (json['today_earnings'] as num).toDouble(),
      todayDeliveries: json['todays_deliveries'],
      requests: (json['delivery_requests'] as List)
          .map((e) => DeliveryRequestRunnerEntity.fromJson(e))
          .toList(),
    );
  }
}
