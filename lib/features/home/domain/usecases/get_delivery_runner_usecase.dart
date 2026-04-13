import 'package:partsrunner/features/home/data/models/delivery_home_runner_model.dart';
import 'package:partsrunner/features/home/domain/repositories/home_repository.dart';

class GetDeliveryRunnerUsecase {
  final HomeRepository _homeRepository;
  GetDeliveryRunnerUsecase(this._homeRepository);

  Future<DeliveryHomeRunnerModel> call() {
    return _homeRepository.getDeliveryRunner();
  }
}
