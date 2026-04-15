import 'package:partsrunner/core/models/delivery_model.dart';

abstract class JobDetailsRepository {
  Future<void> runnerAcceptRequest(String id);
  Future<void> runnerRejectRequest(String id);
  Future<DeliveryModel> getRequestById(String id);
  Future<void> updateDeliveryStatus(String id, String status, List<String>? proofFile);
}
