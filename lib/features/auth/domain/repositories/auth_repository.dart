import 'package:partsrunner/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> getUser();

  /// Login with email/phone and password. Returns the authenticated [UserEntity].
  Future<void> login({
    required String identifier, // email or phone
    required String password,
  });

  /// Register a new user.
  Future<void> signup({
    required String name,
    required String email,
    required String countryCode,
    required String phone,
    required String password,
    required String role, // 'contractor' | 'runner'
  });

  /// Send OTP to the given phone number or email.
  Future<void> sendOtp({required String identifier});

  /// Verify OTP code. Returns the authenticated [UserEntity].
  Future<void> verifyOtp({required String identifier, required String otp});

  /// Reset password after OTP verification.
  Future<void> resetPassword({
    String? email,
    String? phone,
    String? countryCode,
    String? otp,
    required String newPassword,
  });

  Future<void> forgotPassword({
    String? email,
    String? countryCode,
    String? phone,
  });

  Future<void> createContractor({
    required String userId,
    required String companyName,
    required String businessAddress,
  });

  Future<void> createRunner({
    required String userId,
    required String vehicleType,
    required String vehicleModel,
    required String vehicleIdentificationNumber,
  });
}
