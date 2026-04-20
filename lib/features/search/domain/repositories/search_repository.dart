import 'package:partsrunner/core/models/delivery_model.dart';

abstract class SearchRepository {
  Future<List<DeliveryModel>> search(String query, bool isContractor);
}
