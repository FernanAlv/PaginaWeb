import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(String name, double price) {
    // Verificar si el item ya está en el carrito
    final existingItemIndex =
        _cartItems.indexWhere((item) => item['name'] == name);
    if (existingItemIndex >= 0) {
      _cartItems[existingItemIndex]['quantity']++;
    } else {
      _cartItems.add({'name': name, 'quantity': 1, 'price': price});
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _cartItems[index]['quantity']++;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_cartItems[index]['quantity'] > 1) {
      _cartItems[index]['quantity']--;
    } else {
      removeFromCart(index);
    }
    notifyListeners();
  }

  double calculateTotal() {
    double total = 0;
    for (var item in _cartItems) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }
}
