import 'dart:convert';
import 'package:recipe_organizer_frontend/utils/secure_storage.dart';
import 'package:recipe_organizer_frontend/utils/user_storage.dart';

class ShoppingListItem {
  int? id;
  String name;
  String quantity;

  ShoppingListItem({this.id, required this.name, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
    };
  }
}

class SecureStorageShoppingList {
  final String _keyShoppingList = "shopping_list";
  final SecureStorage _secureStorage = SecureStorage();
  final UserStorage user = UserStorage();

  Future<void> insertShoppingListItem(ShoppingListItem item) async {
    final List<String> shoppingList = await _getShoppingList() ?? [];
    shoppingList.add('${item.name}: ${item.quantity}');
    await _updateShoppingList(shoppingList);
  }

  Future<void> insertShoppingListItem2(String name, String quantity) async {
    final List<String> shoppingList = await _getShoppingList() ?? [];
    shoppingList.add('$name: $quantity');
    await _updateShoppingList(shoppingList);
  }

  Future<void> deleteShoppingListItem(int index) async {
    List<String> shoppingList = await _getShoppingList() ?? [];
    if (index >= 0 && index < shoppingList.length) {
      shoppingList.removeAt(index);
      await _updateShoppingList(shoppingList);
    }
  }

  Future<void> deleteAllShoppingListItems() async {
    await _secureStorage.delete(key: _keyShoppingList);
  }

  Future<List<ShoppingListItem>> getShoppingListItems() async {
    final List<String> shoppingList = await _getShoppingList() ?? [];
    return shoppingList.map((item) {
      final parts = item.split(': ');
      return ShoppingListItem(
        name: parts[0],
        quantity: parts[1],
      );
    }).toList();
  }

  Future<List<String>?> _getShoppingList() async {
    final String? shoppingListString = await _secureStorage.read(key: _keyShoppingList);
    return _decodeShoppingList(shoppingListString);
  }

  Future<void> _updateShoppingList(List<String> shoppingList) async {
    await _secureStorage.write(
      key: _keyShoppingList,
      value: _encodeShoppingList(shoppingList),
    );
  }

  String _encodeShoppingList(List<String> shoppingList) {
    return json.encode(shoppingList);
  }

  List<String>? _decodeShoppingList(String? shoppingListString) {
    try {
      final List<dynamic> decodedList = json.decode(shoppingListString ?? '[]');
      return decodedList.cast<String>();
    } catch (e) {
      print('Error decoding shopping list: $e');
      return null;
    }
  }
}
