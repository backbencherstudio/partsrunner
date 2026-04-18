import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
    final savedToken = await _storage.read(key: 'access_token');
    print('Token saved successfully: ${savedToken != null ? "YES" : "NO"}');
  }

  static Future<String?> getToken() async {
    final token = await _storage.read(key: 'access_token');
    print('Getting token: ${token != null ? "FOUND" : "NOT FOUND"}');
    return token;
  }

  static Future<void> deleteAll() async {
    await _storage.deleteAll();
    print('All tokens deleted from secure storage');
  }
}
