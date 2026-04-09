import 'package:partsrunner/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUsecase {
  final AuthRepository _repository;

  const ForgotPasswordUsecase(AuthRepository repository)
    : _repository = repository;

  Future call({String? email, String? countryCode, String? phone}) =>
      _repository.forgotPassword(
        email: email,
        countryCode: countryCode,
        phone: phone,
      );
}
