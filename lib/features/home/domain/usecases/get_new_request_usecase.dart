import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/home/domain/repositories/home_repository.dart';

class GetNewRequestUsecase {
  final HomeRepository _homeRepository;

  GetNewRequestUsecase(this._homeRepository);

  Future<List<DeliveryModel>> call() {
    return _homeRepository.getNewRequest();
  }
}
