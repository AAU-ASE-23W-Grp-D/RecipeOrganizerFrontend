import 'package:recipe_organizer_frontend/utils/secure_storage.dart';

class TokenStorage {
  static const String _jwtKey = 'jwt_token';
  final SecureStorage _storage = SecureStorage();

  // Retrieve the stored JWT token
  Future<String> getToken() async {
    var jwtToken = await _storage.read(key: _jwtKey);
    return jwtToken ?? "";
  }

  // Store the JWT token securely
  Future<void> saveToken(String token) async {
    await _storage.write(key: _jwtKey, value: token);
  }

  // Delete the stored JWT token
  Future<void> deleteToken() async {
    await _storage.delete(key: _jwtKey);
  }
}
