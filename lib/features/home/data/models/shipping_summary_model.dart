import 'package:partsrunner/core/entities/delivery.dart';

/// Main Model for the Shipping Response
class ShippingSummaryModel {
  final List<Delivery> currentShipping;
  final List<Delivery> recentShipping;

  ShippingSummaryModel({
    required this.currentShipping,
    required this.recentShipping,
  });

  factory ShippingSummaryModel.fromJson(Map<String, dynamic> json) {
    return ShippingSummaryModel(
      currentShipping: (json['current_shipping'] as List)
          .map((i) => Delivery.fromJson(i))
          .toList(),
      recentShipping: (json['recent_shipping'] as List)
          .map((i) => Delivery.fromJson(i))
          .toList(),
    );
  }
}
