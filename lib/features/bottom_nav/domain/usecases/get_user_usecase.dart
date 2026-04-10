import 'package:partsrunner/features/bottom_nav/domain/entities/user_entity.dart';
import 'package:partsrunner/features/bottom_nav/domain/repositories/bottom_nav_repository.dart';

class GetUserUsecase {
  final BottomNavRepository _repository;

  GetUserUsecase(this._repository);

  Future<UserEntity> call() {
    return _repository.getUser();
  }
}
