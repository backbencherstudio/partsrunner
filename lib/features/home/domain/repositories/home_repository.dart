import 'package:partsrunner/features/home/data/models/shipping_summary_model.dart';

abstract class HomeRepository {
  Future<void> changeAvailability(bool isOnline);
  Future<ShippingSummaryModel> getDeliveryContractor();
}