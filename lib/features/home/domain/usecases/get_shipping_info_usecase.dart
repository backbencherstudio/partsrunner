import 'package:partsrunner/features/home/data/models/shipping_summary_model.dart';
import 'package:partsrunner/features/home/domain/repositories/home_repository.dart';

class GetShippingInfoUsecase {
  final HomeRepository _homeRepository;
  GetShippingInfoUsecase(this._homeRepository);

  Future<ShippingSummaryModel> call() async {
    return await _homeRepository.getDeliveryContractor();
  }
}