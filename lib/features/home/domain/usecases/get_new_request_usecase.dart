import 'package:partsrunner/features/home/domain/repositories/home_repository.dart';

class GetNewRequestUsecase {
  final HomeRepository _homeRepository;

  GetNewRequestUsecase(this._homeRepository);

  Future<dynamic> call() {
    return _homeRepository.getNewRequest();
  }
}
