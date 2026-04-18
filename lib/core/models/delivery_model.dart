import 'package:partsrunner/core/entities/contractor.dart';
import 'package:partsrunner/core/entities/runner.dart';
import 'package:partsrunner/core/entities/supplier.dart';
import 'package:partsrunner/core/helpers/helper_functions.dart';

class DeliveryModel {
  String? id;
  String? contractorId;
  String? runnerId;
  String? supplierId;
  String? packageName;
  int? weight;
  double? pickupLat;
  double? pickupLng;
  String? pickupDate;
  String? technicianName;
  String? technicianPhone;
  String? deliveryAddress;
  double? deliveryLat;
  double? deliveryLng;
  String? specialInstructions;
  String? totalAmount;
  String? paymentStatus;
  bool? isAvailable;
  String? status;
  DateTime? acceptedAt;
  DateTime? pickedUpAt;
  DateTime? enRouteAt;
  DateTime? deliveredAt;
  double? estimatedDistanceKm;
  int? estimatedTimeMin;
  double? currentDistanceKm;
  int? currentEtaMin;
  List<String>? photoProofUrl;
  int? dispatchIndex;
  String? offeredRunnerId;
  DateTime? offerExpiresAt;
  bool? dispatchCompleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  Runner? runner;
  Supplier? supplier;
  Contractor? contractor;
  List<dynamic>? statusHistory;

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
    this.runner,
    this.supplier,
    this.contractor,
    this.statusHistory,
  });

  DeliveryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contractorId = json['contractor_id'];
    runnerId = json['runner_id'];
    supplierId = json['supplier_id'];
    packageName = json['package_name'];
    weight = HelperFunctions.toInt(json['weight']);
    pickupLat = HelperFunctions.toDouble(json['pickup_lat']);
    pickupLng = HelperFunctions.toDouble(json['pickup_lng']);
    pickupDate = json['pickup_date'];
    technicianName = json['technician_name'];
    technicianPhone = json['technician_phone'];
    deliveryAddress = json['delivery_address'];
    deliveryLat = HelperFunctions.toDouble(json['delivery_lat']);
    deliveryLng = HelperFunctions.toDouble(json['delivery_lng']);
    specialInstructions = json['special_instructions'];
    totalAmount = json['total_amount'];
    paymentStatus = json['payment_status'];
    isAvailable = json['is_available'];
    status = json['status'];
    acceptedAt = DateTime.tryParse(json['accepted_at'] ?? '');
    pickedUpAt = DateTime.tryParse(json['picked_up_at'] ?? '');
    enRouteAt = DateTime.tryParse(json['en_route_at'] ?? '');
    deliveredAt = DateTime.tryParse(json['delivered_at'] ?? '');
    estimatedDistanceKm = HelperFunctions.toDouble(json['estimated_distance_km']);
    estimatedTimeMin = HelperFunctions.toInt(json['estimated_time_min']);
    currentDistanceKm = HelperFunctions.toDouble(json['current_distance_km']);
    currentEtaMin = HelperFunctions.toInt(json['current_eta_min']);
    if (json['photo_proof_url'] != null) {
      photoProofUrl = <String>[];
      json['photo_proof_url'].forEach((v) {
        photoProofUrl!.add(v as String);
      });
    }
    dispatchIndex = HelperFunctions.toInt(json['dispatch_index']);
    offeredRunnerId = json['offered_runner_id'];
    offerExpiresAt = DateTime.tryParse(json['offer_expires_at'] ?? '');
    dispatchCompleted = json['dispatch_completed'];
    createdAt = DateTime.tryParse(json['created_at'] ?? '');
    updatedAt = DateTime.tryParse(json['updated_at'] ?? '');
    deletedAt = DateTime.tryParse(json['deleted_at'] ?? '');
    runner = json['runner'] != null
        ? Runner.fromJson(json['runner'])
        : null;
    supplier = json['supplier'] != null
        ? Supplier.fromJson(json['supplier'])
        : null;
    contractor = json['contractor'] != null
        ? Contractor.fromJson(json['contractor'])
        : null;
    statusHistory = json['status_history'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['contractor_id'] = contractorId;
    data['runner_id'] = runnerId;
    data['supplier_id'] = supplierId;
    data['package_name'] = packageName;
    data['weight'] = weight;
    data['pickup_lat'] = pickupLat;
    data['pickup_lng'] = pickupLng;
    data['pickup_date'] = pickupDate;
    data['technician_name'] = technicianName;
    data['technician_phone'] = technicianPhone;
    data['delivery_address'] = deliveryAddress;
    data['delivery_lat'] = deliveryLat;
    data['delivery_lng'] = deliveryLng;
    data['special_instructions'] = specialInstructions;
    data['total_amount'] = totalAmount;
    data['payment_status'] = paymentStatus;
    data['is_available'] = isAvailable;
    data['status'] = status;
    data['accepted_at'] = acceptedAt;
    data['picked_up_at'] = pickedUpAt;
    data['en_route_at'] = enRouteAt;
    data['delivered_at'] = deliveredAt;
    data['estimated_distance_km'] = estimatedDistanceKm;
    data['estimated_time_min'] = estimatedTimeMin;
    data['current_distance_km'] = currentDistanceKm;
    data['current_eta_min'] = currentEtaMin;
    if (photoProofUrl != null) {
      data['photo_proof_url'] = photoProofUrl;
    }
    data['dispatch_index'] = dispatchIndex;
    data['offered_runner_id'] = offeredRunnerId;
    data['offer_expires_at'] = offerExpiresAt;
    data['dispatch_completed'] = dispatchCompleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if(runner != null){
      data['runner'] = runner!.toJson();
    }
    if (supplier != null) {
      data['supplier'] = supplier!.toJson();
    }
    if (contractor != null) {
      data['contractor'] = contractor!.toJson();
    }
    data['status_history'] = statusHistory;
    return data;
  }

  static List<DeliveryModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => DeliveryModel.fromJson(json)).toList();
  }
}
