import 'package:partsrunner/features/bottom_nav/domain/repositories/bottom_nav_repository.dart';
import 'package:partsrunner/features/bottom_nav/data/models/bottom_nav_model.dart';

class GetUserUsecase {
  final BottomNavRepository _repository;

  GetUserUsecase(this._repository);

  Future<BottomNavModel> call() {
    return _repository.getUser();
  }
}
