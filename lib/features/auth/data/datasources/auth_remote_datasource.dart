import 'package:partsrunner/core/services/api_service/api_client.dart';
import 'package:partsrunner/core/services/api_service/api_endpoint.dart';
import 'package:partsrunner/core/services/api_service/token_service.dart';
import 'package:partsrunner/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<UserModel> getUser();

  Future<void> login({
    required String identifier,
    String? countryCode,
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

  Future<void> verifyOtp({required String identifier, required String otp});

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

  Future<void> newPassword({required String password, required String newPassword});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  const AuthRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<UserModel> getUser() async {
    final token = await TokenService.getToken();
    print("Token: $token");
    try {
      final response = await _apiClient.get(ApiEndpoints.me);
      if (response['data'] != null) {
        return UserModel.fromJson(response['data']);
      }
      throw Exception('Failed to get user');
    } catch (e) {
      print("Error getting user: $e");
      rethrow;
    }
  }

  @override
  Future<void> login({
    required String identifier,
    String? countryCode,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.login,
        body: {'email': identifier, 'password': password},
      );

      if (response['success'] == true && response['authorization'] != null) {
        final auth = response['authorization'];
        final accessToken = auth['access_token'] as String;
        // Store token
        await TokenService.saveToken(accessToken);
        final token = await TokenService.getToken();
        print('Token after login: $token');
        // Decode JWT to get user details
        // final parts = accessToken.split('.');
        // if (parts.length >= 2) {
        //   final payloadStr = utf8.decode(
        //     base64Url.decode(base64Url.normalize(parts[1])),
        //   );
        //   // final payload = jsonDecode(payloadStr);

        //   // return UserModel(
        //   //   id: payload['sub']?.toString() ?? 'unknown-id',
        //   //   name: identifier.split('@').first,
        //   //   email: payload['email']?.toString() ?? identifier,
        //   //   phone: '',
        //   //   role: UserRole.values.firstWhere(
        //   //     (e) =>
        //   //         e.name.toLowerCase() ==
        //   //         (response['type']?.toString().toLowerCase() ?? 'contractor'),
        //   //     orElse: () => UserRole.contractor,
        //   //   ),
        //   // );
        // }
        return;
      }

      throw Exception(response['message'] ?? 'Invalid response from server');
    } catch (e) {
      print("Login failed: $e");
    }
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
    final requestBody = {
      'name': name,
      'email': email,
      'country_code': countryCode,
      'phone_number': phone,
      'password': password,
      'type': role.toUpperCase(),
    };

    try {
      final response = await _apiClient.post(
        ApiEndpoints.register,
        body: requestBody,
      );

      if (response['success']) {
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
    if (response['success']) {
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
  Future<void> verifyOtp({
    required String identifier,
    required String otp,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.verifyEmail,
      body: {'email': identifier, 'token': otp},
    );

    if (response is Map<String, dynamic> && response['success'] == true) {
      if (response['user'] != null) {
        final userJson = response['user'];
        final pref = await SharedPreferences.getInstance();
        pref.setString('userId', userJson['id'].toString());
      }
      // return UserModel(
      //   id: userJson['id']?.toString() ?? 'unknown-id',
      //   name: userJson['name']?.toString() ?? '',
      //   email: userJson['email']?.toString() ?? '',
      //   phone: '', // Not returned in the verify OTP payload
      //   role: UserRole
      //       .contractor, // Defaulting as role is not included in verify payload
      // );
      return;
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
    final response = await _apiClient.post(
      ApiEndpoints.runnerCreate,
      body: {
        'user_id': userId,
        'vehicle_type': vehicleType,
        'vehicle_model': vehicleModel,
        'vehicle_identification_number': vehicleIdentificationNumber,
      },
    );
    if (response is Map<String, dynamic> && response['success'] == true) {
      return;
    } else {
      throw Exception(response['message'] ?? 'Failed to create runner');
    }
  }

  @override
  Future<void> newPassword({required String password, required String newPassword}) {
    return _apiClient.post(
      ApiEndpoints.changePassword,
      body: {
        'old_password': password,
        'new_password': newPassword,
      },
    );
  }
}
