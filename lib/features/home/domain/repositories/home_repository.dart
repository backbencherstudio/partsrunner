import 'package:partsrunner/features/home/data/models/delivery_home_runner_model.dart';
import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/home/data/models/shipping_summary_model.dart';

abstract class HomeRepository {
  Future<void> changeAvailability(bool isOnline);
  Future<DeliveryHomeRunnerModel> getDeliveryRunner();
  Future<List<DeliveryModel>> getNewRequest();

  Future<ShippingSummaryModel> getDeliveryContractor();
}
