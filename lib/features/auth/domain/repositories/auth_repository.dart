import 'package:partsrunner/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  /// Login with email/phone and password. Returns the authenticated [UserEntity].
  Future<UserEntity> login({
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
  Future<UserEntity> verifyOtp({
    required String identifier,
    required String otp,
  });

  /// Reset password after OTP verification.
  Future<void> resetPassword({
    required String identifier,
    required String newPassword,
  });

  // Future<void> contractorCreate({
  //   required String name,
  //   required String email,
  //   required String phone,
  //   required String password,
  //   required String role, // 'contractor' | 'runner'
  // });
}
