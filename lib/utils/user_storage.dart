import 'package:recipe_organizer_frontend/models/user.dart';
import 'package:recipe_organizer_frontend/utils/secure_storage.dart';
import 'package:recipe_organizer_frontend/utils/token_storage.dart';

class UserStorage {
  static const String _userIdKey = 'user_id';
  static const String _userNameKey = 'user_name';
  static const String _userRolesKey = 'user_roles';

  static const String _totalCreatedRecipesKey = 'total_created_recipes';

  final SecureStorage _storage = SecureStorage();
  final TokenStorage _tokenStorage = TokenStorage();

  // Retrieve the stored user id
  Future<String?> getId() async {
    return _storage.read(key: _userIdKey);
  }

  // Retrieve the stored user name
  Future<String?> getUserName() async {
    return _storage.read(key: _userNameKey);
  }

  // Retrieve the stored user roles
  Future<List<String>?> getRoles() async {
    String? roles = await _storage.read(key: _userRolesKey);
    return roles?.split(',');
  }

  Future<int?> getTotalCreatedRecipes() async {
    return int.tryParse(await _storage.read(key: _totalCreatedRecipesKey) ?? '');
  }

  Future<void> saveTotalCreatedRecipes(int totalCreatedRecipes) async {
    await _storage.write(key: _totalCreatedRecipesKey, value: totalCreatedRecipes.toString());
  }

  // Store the user info and JWT token securely
  Future<void> saveUser(User user) async {
    await _storage.write(key: _userIdKey, value: user.id.toString());
    await _storage.write(key: _userNameKey, value: user.username);
    await _storage.write(key: _userRolesKey, value: user.roles.join(','));
    await _tokenStorage.saveToken(user.token);
  }
}
