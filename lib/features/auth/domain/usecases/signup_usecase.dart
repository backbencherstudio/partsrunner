import 'package:partsrunner/features/auth/domain/entities/user_entity.dart';
import 'package:partsrunner/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase {
  const SignupUseCase(this._repository);

  final AuthRepository _repository;

  Future<UserEntity> call({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) =>
      _repository.signup(
        name: name,
        email: email,
        phone: phone,
        password: password,
        role: role,
      );
}
