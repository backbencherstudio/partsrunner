import 'package:partsrunner/core/entities/runner.dart';
import 'package:partsrunner/core/entities/supplier.dart';
import 'package:partsrunner/features/live_tracking/domain/entities/live_tracking.dart';

class Delivery {
  final String id;
  final String packageName;
  final String deliveryAddress;
  final String status;
  final String paymentStatus;
  final String totalAmount;
  final DateTime updatedAt;
  final Supplier supplier;
  final Runner runner;
  final LiveTracking liveTracking;

  Delivery({
    required this.id,
    required this.packageName,
    required this.deliveryAddress,
    required this.status,
    required this.paymentStatus,
    required this.totalAmount,
    required this.updatedAt,
    required this.supplier,
    required this.runner,
    required this.liveTracking,
  });
}
