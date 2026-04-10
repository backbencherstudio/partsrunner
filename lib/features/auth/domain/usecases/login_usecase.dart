import 'package:partsrunner/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call({
    required String identifier,
    required String password,
  }) =>
      _repository.login(identifier: identifier, password: password);
}
