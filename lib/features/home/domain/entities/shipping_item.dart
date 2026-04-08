import 'package:partsrunner/features/home/domain/entities/runner.dart';
import 'package:partsrunner/features/home/domain/entities/supplier.dart';

/// Shipping Item Entity
class ShippingItem {
  final String id;
  final String packageName;
  final String deliveryAddress;
  final DateTime pickupDate;
  final String status;
  final String paymentStatus;
  final double totalAmount;
  final List<String> photoProofUrl;
  final Supplier supplier;
  final Runner runner;

  ShippingItem({
    required this.id,
    required this.packageName,
    required this.deliveryAddress,
    required this.pickupDate,
    required this.status,
    required this.paymentStatus,
    required this.totalAmount,
    required this.photoProofUrl,
    required this.supplier,
    required this.runner,
  });

  factory ShippingItem.fromJson(Map<String, dynamic> json) {
    return ShippingItem(
      id: json['id'],
      packageName: json['package_name'],
      deliveryAddress: json['delivery_address'],
      pickupDate: DateTime.parse(json['pickup_date']),
      status: json['status'],
      paymentStatus: json['payment_status'],
      totalAmount: double.parse(json['total_amount'].toString()),
      photoProofUrl: List<String>.from(json['photo_proof_url']),
      supplier: Supplier.fromJson(json['supplier']),
      runner: Runner.fromJson(json['runner']),
    );
  }
}


