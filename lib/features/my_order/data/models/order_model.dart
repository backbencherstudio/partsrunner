import 'package:partsrunner/core/entities/delivery.dart';
import 'package:partsrunner/core/entities/runner.dart';
import 'package:partsrunner/core/entities/supplier.dart';
import 'package:partsrunner/features/live_tracking/domain/entities/live_tracking.dart';

class OrderModel extends Delivery {
  OrderModel({
    required super.id,
    required super.packageName,
    required super.deliveryAddress,
    required super.status,
    required super.paymentStatus,
    required super.totalAmount,
    required super.updatedAt,
    required super.supplier,
    required super.runner,
    required super.liveTracking,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      packageName: json['package_name'],
      deliveryAddress: json['delivery_address'],
      status: json['status'],
      paymentStatus: json['payment_status'],
      totalAmount: json['total_amount'],
      updatedAt: DateTime.parse(json['updated_at']),
      supplier: Supplier.fromJson(json['supplier']),
      runner: Runner.fromJson(json['runner']),
      liveTracking: LiveTracking.fromJson(json['live_tracking']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'package_name': packageName,
      'delivery_address': deliveryAddress,
      'status': status,
      'payment_status': paymentStatus,
      'total_amount': totalAmount,
      'updated_at': updatedAt.toIso8601String(),
      'supplier': supplier.toJson(),
      'runner': runner.toJson(),
      'live_tracking': liveTracking.toJson(),
    };
  }

  static List<OrderModel> getActiveDeliveriesFromList(List<dynamic> jsonList) {
    return jsonList.map((item) => OrderModel.fromJson(item)).toList();
  }
}
