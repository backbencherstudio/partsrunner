import 'package:partsrunner/features/home/domain/entities/shipping_item.dart';

/// Main Model for the Shipping Response
class ShippingSummaryModel {
  final List<ShippingItem> currentShipping;
  final List<ShippingItem> recentShipping;
  final Map<String, int> limits;

  ShippingSummaryModel({
    required this.currentShipping,
    required this.recentShipping,
    required this.limits,
  });

  factory ShippingSummaryModel.fromJson(Map<String, dynamic> json) {
    var data = json['data'];
    return ShippingSummaryModel(
      currentShipping: (data['current_shipping'] as List)
          .map((i) => ShippingItem.fromJson(i))
          .toList(),
      recentShipping: (data['recent_shipping'] as List)
          .map((i) => ShippingItem.fromJson(i))
          .toList(),
      limits: Map<String, int>.from(data['limits']),
    );
  }
}

