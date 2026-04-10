import 'package:partsrunner/core/entities/live_tracking.dart';
import 'package:partsrunner/core/entities/runner.dart';
import 'package:partsrunner/core/entities/supplier.dart';

class Delivery {
  String? id;
  String? packageName;
  String? deliveryAddress;
  String? status;
  String? paymentStatus;
  String? totalAmount;
  double? estimatedDistanceKm;
  int? estimatedTimeMin;
  String? updatedAt;
  Supplier? supplier;
  Runner? runner;
  LiveTracking? liveTracking;

  Delivery({
    this.id,
    this.packageName,
    this.deliveryAddress,
    this.status,
    this.paymentStatus,
    this.totalAmount,
    this.estimatedDistanceKm,
    this.estimatedTimeMin,
    this.updatedAt,
    this.supplier,
    this.runner,
    this.liveTracking,
  });

  Delivery.fromJson(Map<String, dynamic> json) {
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
    runner = json['runner'] != null ? Runner.fromJson(json['runner']) : null;
    liveTracking = json['live_tracking'] != null
        ? LiveTracking.fromJson(json['live_tracking'])
        : null;
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
  List<Delivery> getDeliveriesFromList(List<dynamic> jsonList) {
  return jsonList.map((item) => Delivery.fromJson(item)).toList();
}
}
