import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common/sqlite_api.dart';


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


  
class DatabaseHelper {
  SharedPreferences? _prefs;

  Future<void> open() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> insertShoppingListItem(ShoppingListItem item) async {
    final List<String> shoppingList = _prefs!.getStringList('shopping_list') ?? [];
    shoppingList.add('${item.name}: ${item.quantity}');
    await _prefs!.setStringList('shopping_list', shoppingList);
  }

    Future<void> deleteShoppingListItem(int index) async {
    final List<String> shoppingList = _prefs!.getStringList('shopping_list') ?? [];
    if (index >= 0 && index < shoppingList.length) {
      shoppingList.removeAt(index);
      await _prefs!.setStringList('shopping_list', shoppingList);
    }
  }

  Future<void> deleteAllShoppingListItems() async {
    await _prefs!.remove('shopping_list');
  }

  Future<List<ShoppingListItem>> getShoppingListItems() async {
    final List<String> shoppingList = _prefs!.getStringList('shopping_list') ?? [];
    return shoppingList.map((item) {
      final parts = item.split(': ');
      return ShoppingListItem(
        name: parts[0],
        quantity: parts[1],
      );
    }).toList();
  }
}

class ShoppingListProvider extends ChangeNotifier {
  List<ShoppingListItem> _shoppingList = [];
  List<ShoppingListItem> get shoppingList => _shoppingList;

  void addItemToShoppingList(ShoppingListItem item) {
    _shoppingList.add(item);
    notifyListeners();
  }
}
