import 'dart:convert';

import 'package:partsrunner/core/ApiService/ApiClient.dart';
import 'package:partsrunner/core/ApiService/ApiEndPoint.dart';
import 'package:partsrunner/core/ApiService/TokenStorage.dart';
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
    required String identifier,
    required String newPassword,
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
  Future<void> sendOtp({required String identifier}) async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO: replace with real API call
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
    required String identifier,
    required String newPassword,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO: replace with real API call
  }
}
