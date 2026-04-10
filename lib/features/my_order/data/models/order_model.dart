import 'package:partsrunner/core/entities/delivery.dart';
import 'package:partsrunner/core/entities/live_tracking.dart';
import 'package:partsrunner/core/entities/supplier.dart';
import 'package:partsrunner/core/entities/runner.dart';

class OrderModel extends Delivery {
  OrderModel({
    super.id,
    super.packageName,
    super.deliveryAddress,
    super.status,
    super.paymentStatus,
    super.totalAmount,
    super.estimatedDistanceKm,
    super.estimatedTimeMin,
    super.updatedAt,
    super.supplier,
    super.runner,
    super.liveTracking,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageName = json['package_name'];
    deliveryAddress = json['delivery_address'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    totalAmount = json['total_amount'];
    estimatedDistanceKm = json['estimated_distance_km'];
    estimatedTimeMin = json['estimated_time_min'];
    updatedAt = json['updated_at'];
    supplier = json['supplier'] != null
        ? Supplier.fromJson(json['supplier'])
        : null;
    runner =
        json['runner'] != null ? Runner.fromJson(json['runner']) : null;
    liveTracking = (json['live_tracking'] != null
        ? LiveTracking.fromJson(json['live_tracking'])
        : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['package_name'] = packageName;
    data['delivery_address'] = deliveryAddress;
    data['status'] = status;
    data['payment_status'] = paymentStatus;
    data['total_amount'] = totalAmount;
    data['estimated_distance_km'] = estimatedDistanceKm;
    data['estimated_time_min'] = estimatedTimeMin;
    data['updated_at'] = updatedAt;
    if (supplier != null) {
      data['supplier'] = supplier!.toJson();
    }
    if (runner != null) {
      data['runner'] = runner!.toJson();
    }
    if (liveTracking != null) {
      data['live_tracking'] = liveTracking!.toJson();
    }
    return data;
  }

  static List<OrderModel> getOrdersFromList(List<dynamic> jsonList) {
  return jsonList.map((item) => OrderModel.fromJson(item)).toList();
}
}
