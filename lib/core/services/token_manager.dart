import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Save token securely
  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'authToken', value: token);
  }

  // Get token from secure storage
  static Future<String?> getToken() async {
    return await _storage.read(key: 'authToken');
  }

  // Clear token from secure storage
  static Future<void> clearToken() async {
    await _storage.delete(key: 'authToken');
  }
}
