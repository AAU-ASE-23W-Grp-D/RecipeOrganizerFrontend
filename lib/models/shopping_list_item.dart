class ShoppingListItem {
  int? id;
  String name;
  String quantity;

//Item for the shopping list to show in the screen
  ShoppingListItem({this.id, required this.name, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
    };
  }
}