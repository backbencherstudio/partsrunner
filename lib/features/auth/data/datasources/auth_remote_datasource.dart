import 'dart:convert';

import 'package:partsrunner/core/api_service/api_client.dart';
import 'package:partsrunner/core/api_service/api_end_point.dart';
import 'package:partsrunner/core/api_service/token_storage.dart';
import 'package:partsrunner/core/constant/user_role.dart';
import 'package:partsrunner/features/auth/data/models/user_model.dart';

/// Remote data source for authentication.
///
/// Replace the stub implementations with real HTTP calls when the API is ready.
/// Example:
///   final response = await http.post(
///     Uri.parse('$baseUrl/auth/login'),
///     body: jsonEncode({'email': identifier, 'password': password}),
///   );
///   final json = jsonDecode(response.body) as Map<String, dynamic>;
///   return UserModel.fromJson(json['user']);
abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String identifier,
    required String password,
  });

  Future<void> signup({
    required String name,
    required String email,
    required String countryCode,
    required String phone,
    required String password,
    required String role,
  });

  Future<void> sendOtp({required String identifier});

  Future<UserModel> verifyOtp({
    required String identifier,
    required String otp,
  });

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

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  const AuthRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<UserModel> login({
    required String identifier,
    required String password,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.login,
      body: {'email': identifier, 'password': password},
    );

    if (response is Map<String, dynamic> &&
        response['success'] == true &&
        response['authorization'] != null) {
      final auth = response['authorization'];
      final accessToken = auth['access_token'] as String;

      // Store token
      final tokenStorage = TokenStorage();
      await tokenStorage.saveToken(accessToken);

      // Decode JWT to get user details
      final parts = accessToken.split('.');
      if (parts.length >= 2) {
        final payloadStr = utf8.decode(
          base64Url.decode(base64Url.normalize(parts[1])),
        );
        final payload = jsonDecode(payloadStr);

        return UserModel(
          id: payload['sub']?.toString() ?? 'unknown-id',
          name: identifier.split('@').first,
          email: payload['email']?.toString() ?? identifier,
          phone: '',
          role: UserRole.values.firstWhere(
            (e) =>
                e.name.toLowerCase() ==
                (response['type']?.toString().toLowerCase() ?? 'contractor'),
            orElse: () => UserRole.contractor,
          ),
        );
      }
    }

    throw Exception(response['message'] ?? 'Invalid response from server');
  }

  @override
  Future<void> signup({
    required String name,
    required String email,
    required String countryCode,
    required String phone,
    required String password,
    required String role,
  }) async {
    print('=== SIGNUP DEBUG ===');
    print('Name: $name');
    print('Email: $email');
    print('Country Code: $countryCode');
    print('Phone: $phone');
    print('Password: ${password.isNotEmpty ? '***' : 'EMPTY'}');
    print('Role: $role');
    print('API Endpoint: ${ApiEndpoints.register}');

    final requestBody = {
      'name': name,
      'email': email,
      'country_code': countryCode,
      'phone_number': phone,
      'password': password,
      'type': role.toUpperCase(),
    };

    print('Request Body: $requestBody');

    try {
      final response = await _apiClient.post(
        ApiEndpoints.register,
        body: requestBody,
      );

      print('Response: $response');

      if (response is Map<String, dynamic> && response['success'] == true) {
        print('Signup successful');
        return;
      } else {
        print('Signup failed: ${response['message'] ?? 'Unknown error'}');
        throw Exception(response['message'] ?? 'Signup failed');
      }
    } catch (e) {
      print('Signup error: $e');
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<void> forgotPassword({
    String? email,
    String? countryCode,
    String? phone,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.forgotPassword,
      body: {'email': email, 'country_code': countryCode, 'phone': phone},
    );
    if (response['success'] == true) {
      return;
    }
    throw Exception(response['message'] ?? 'Failed to send OTP');
  }

  @override
  Future<void> sendOtp({required String identifier}) async {
    final response = await _apiClient.post(
      ApiEndpoints.resendVerificationEmail,
      body: {'email': identifier},
    );
    if (response is Map<String, dynamic> && response['success'] == true) {
      return;
    } else {
      throw Exception(response['message'] ?? 'Failed to send OTP');
    }
  }

  @override
  Future<UserModel> verifyOtp({
    required String identifier,
    required String otp,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.verifyEmail,
      body: {'email': identifier, 'token': otp},
    );

    if (response is Map<String, dynamic> &&
        response['success'] == true &&
        response['user'] != null) {
      final userJson = response['user'];
      return UserModel(
        id: userJson['id']?.toString() ?? 'unknown-id',
        name: userJson['name']?.toString() ?? '',
        email: userJson['email']?.toString() ?? '',
        phone: '', // Not returned in the verify OTP payload
        role: UserRole
            .contractor, // Defaulting as role is not included in verify payload
      );
    }

    throw Exception(response['message'] ?? 'OTP verification failed');
  }

  @override
  Future<void> resetPassword({
    String? email,
    String? phone,
    String? countryCode,
    String? otp,
    required String newPassword,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.resetPassword,
      body: {
        'email': email,
        'country_code': countryCode,
        'phone_number': phone,
        'token': otp,
        'password': newPassword,
      },
    );

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Password reset failed');
    }
  }

  @override
  Future<void> createContractor({
    required String userId,
    required String companyName,
    required String businessAddress,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.contractorCreate,
      body: {
        'user_id': userId,
        'company_name': companyName,
        'business_address': businessAddress,
      },
    );
    print(response);
    if (response is Map<String, dynamic> && response['success'] == true) {
      print("Contractor created successfully");
      return;
    } else {
      throw Exception(response['message'] ?? 'Failed to create contractor');
    }
  }

  @override
  Future<void> createRunner({
    required String userId,
    required String vehicleType,
    required String vehicleModel,
    required String vehicleIdentificationNumber,
  }) async {
    print("$userId\n$vehicleType\n$vehicleModel\n$vehicleIdentificationNumber");
    final response = await _apiClient.post(
      ApiEndpoints.runnerCreate,
      body: {
        'user_id': userId,
        'vehicle_type': vehicleType,
        'vehicle_model': vehicleModel,
        'vehicle_identification_number': vehicleIdentificationNumber,
      },
    );
    print(response);
    if (response is Map<String, dynamic> && response['success'] == true) {
      print("Runner created successfully");
      return;
    } else {
      throw Exception(response['message'] ?? 'Failed to create runner');
    }
  }
}
