import 'package:partsrunner/features/active_tracking/data/models/active_delivery_model.dart';

abstract class ActiveDeliveriesRepository {
  Future<List<ActiveDeliveryModel>> getActiveDeliveries();
}
