abstract class ProfileRepository {
  Future<Map<String, dynamic>> changePassword(String oldPassword, String newPassword);
}
