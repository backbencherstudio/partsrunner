import 'package:partsrunner/core/models/delivery_model.dart';

abstract class ActiveJobsRepository {
  Future<List<DeliveryModel>> getAllDeliveries();
  Future<List<DeliveryModel>> getOngoingDeliveries();
  Future<List<DeliveryModel>> getCompletedDeliveries();
  Future<List<DeliveryModel>> getCanceledDeliveries();
}