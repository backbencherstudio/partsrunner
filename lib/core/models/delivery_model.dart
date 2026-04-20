import 'package:partsrunner/core/entities/contractor.dart';
import 'package:partsrunner/core/entities/live_tracking.dart';
import 'package:partsrunner/core/entities/runner.dart';
import 'package:partsrunner/core/entities/supplier.dart';
import 'package:partsrunner/core/helpers/helper_functions.dart';

class DeliveryModel {
  final String? id;
  final String? contractorId;
  final String? runnerId;
  final String? supplierId;
  final String? packageName;
  final double? weight;
  final double? pickupLat;
  final double? pickupLng;
  final DateTime? pickupDate;
  final String? technicianName;
  final String? technicianPhone;
  final String? deliveryAddress;
  final double? deliveryLat;
  final double? deliveryLng;
  final String? specialInstructions;
  final String? totalAmount;
  final String? paymentStatus;
  final bool? isAvailable;
  final String? status;
  final DateTime? acceptedAt;
  final DateTime? pickedUpAt;
  final DateTime? enRouteAt;
  final DateTime? deliveredAt;
  final double? estimatedDistanceKm;
  final int? estimatedTimeMin;
  final double? currentDistanceKm;
  final int? currentEtaMin;
  final List<dynamic>? photoProofUrl;
  final int? dispatchIndex;
  final String? offeredRunnerId;
  final DateTime? offerExpiresAt;
  final bool? dispatchCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final Supplier? supplier;
  final Runner? runner;
  final Contractor? contractor;
  final LiveTracking? liveTracking;

  DeliveryModel({
    this.id,
    this.contractorId,
    this.runnerId,
    this.supplierId,
    this.packageName,
    this.weight,
    this.pickupLat,
    this.pickupLng,
    this.pickupDate,
    this.technicianName,
    this.technicianPhone,
    this.deliveryAddress,
    this.deliveryLat,
    this.deliveryLng,
    this.specialInstructions,
    this.totalAmount,
    this.paymentStatus,
    this.isAvailable,
    this.status,
    this.acceptedAt,
    this.pickedUpAt,
    this.enRouteAt,
    this.deliveredAt,
    this.estimatedDistanceKm,
    this.estimatedTimeMin,
    this.currentDistanceKm,
    this.currentEtaMin,
    this.photoProofUrl,
    this.dispatchIndex,
    this.offeredRunnerId,
    this.offerExpiresAt,
    this.dispatchCompleted,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.contractor,
    this.supplier,
    this.runner,
    this.liveTracking,
  });

  factory DeliveryModel.fromJson(Map<String, dynamic> json) => DeliveryModel(
    id: json["id"],
    contractorId: json["contractor_id"],
    runnerId: json["runner_id"],
    supplierId: json["supplier_id"],
    packageName: json["package_name"],
    weight: HelperFunctions.toDouble(json["weight"]),
    pickupLat: HelperFunctions.toDouble(json["pickup_lat"]),
    pickupLng: HelperFunctions.toDouble(json["pickup_lng"]),
    pickupDate: json["pickup_date"] == null
        ? null
        : DateTime.parse(json["pickup_date"]),
    technicianName: json["technician_name"],
    technicianPhone: json["technician_phone"],
    deliveryAddress: json["delivery_address"],
    deliveryLat: HelperFunctions.toDouble(json["delivery_lat"]),
    deliveryLng: HelperFunctions.toDouble(json["delivery_lng"]),
    specialInstructions: json["special_instructions"],
    totalAmount: json["total_amount"],
    paymentStatus: json["payment_status"],
    isAvailable: json["is_available"],
    status: json["status"],
    acceptedAt: json["accepted_at"] == null
        ? null
        : DateTime.parse(json["accepted_at"]),
    pickedUpAt: json["picked_up_at"] == null
        ? null
        : DateTime.parse(json["picked_up_at"]),
    enRouteAt: json["en_route_at"] == null
        ? null
        : DateTime.parse(json["en_route_at"]),
    deliveredAt: json["delivered_at"] == null
        ? null
        : DateTime.parse(json["delivered_at"]),
    estimatedDistanceKm: json["estimated_distance_km"]?.toDouble(),
    estimatedTimeMin: json["estimated_time_min"],
    currentDistanceKm: json["current_distance_km"],
    currentEtaMin: json["current_eta_min"],
    photoProofUrl: json["photo_proof_url"] == null
        ? []
        : List<dynamic>.from(json["photo_proof_url"]!),
    dispatchIndex: json["dispatch_index"],
    offeredRunnerId: json["offered_runner_id"],
    offerExpiresAt: json["offer_expires_at"] == null
        ? null
        : DateTime.parse(json["offer_expires_at"]),
    dispatchCompleted: json["dispatch_completed"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null
        ? null
        : DateTime.parse(json["deleted_at"]),
    contractor: json["contractor"] == null
        ? null
        : Contractor.fromJson(json["contractor"]),
    supplier: json["supplier"] == null
        ? null
        : Supplier.fromJson(json["supplier"]),
    runner: json["runner"] == null ? null : Runner.fromJson(json["runner"]),
    liveTracking: json["live_tracking"] == null
        ? null
        : LiveTracking.fromJson(json["live_tracking"]),
  );

  static List<DeliveryModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => DeliveryModel.fromJson(item)).toList();
  }
}
