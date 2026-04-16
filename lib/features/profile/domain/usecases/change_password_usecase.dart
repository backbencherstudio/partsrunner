import 'package:partsrunner/features/profile/domain/repositories/profile_repository.dart';

class ChangePasswordUsecase {
  final ProfileRepository _profileRepository;
  ChangePasswordUsecase(this._profileRepository);
  Future<Map<String, dynamic>> call(String oldPassword, String newPassword) {
    return _profileRepository.changePassword(oldPassword, newPassword);
  }
}
