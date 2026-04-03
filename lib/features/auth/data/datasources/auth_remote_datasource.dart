import 'package:partsrunner/core/ApiService/ApiClient.dart';
import 'package:partsrunner/core/ApiService/ApiEndPoint.dart';
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

  Future<UserModel> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  });

  Future<void> sendOtp({required String identifier});

  Future<bool> verifyOtp({required String identifier, required String otp});

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
    print(response);
    if (password.isEmpty) throw Exception('Invalid credentials');
    return UserModel(
      id: 'stub-user-id-123',
      name: 'Demo User',
      email: identifier.contains('@') ? identifier : '',
      phone: identifier.contains('@') ? '' : identifier,
      role: UserRole.contractor,
    );
  }

  @override
  Future<UserModel> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO: replace with real API call + UserModel.fromJson(json)
    return UserModel(
      id: 'stub-new-user-id-456',
      name: name,
      email: email,
      phone: phone,
      role: UserRole.values.firstWhere(
        (e) => e.name == role,
        orElse: () => UserRole.contractor,
      ),
    );
  }

  @override
  Future<void> sendOtp({required String identifier}) async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO: replace with real API call
  }

  @override
  Future<bool> verifyOtp({
    required String identifier,
    required String otp,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    // TODO: replace with real API call
    return true;
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
