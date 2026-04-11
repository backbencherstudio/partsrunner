import 'package:partsrunner/features/auth/data/models/user_model.dart';
import 'package:partsrunner/features/auth/domain/repositories/auth_repository.dart';

class GetUserUsecase {
  final AuthRepository _repository;

  GetUserUsecase(this._repository);

  Future<UserModel> call() {
    return _repository.getUser();
  }
}
