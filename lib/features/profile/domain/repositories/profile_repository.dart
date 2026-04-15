abstract class ProfileRepository {
  Future<void> changePassword(String oldPassword, String newPassword);
}
