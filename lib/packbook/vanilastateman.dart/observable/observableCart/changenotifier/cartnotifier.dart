import 'package:flutter/foundation.dart';

class CartNotifier extends ChangeNotifier {
  final Map<String, CartListItem> _items = {};
  final double _totalPrice = 0;
  final int _totalItems = 0;

  List<CartListItem> get items => _items.values.toList();
  double get totalPrice => _totalPrice;
  int get totalItems => _totalItems;
}

class CartListItem {
  final Product? product;
  final num? quantity;

  CartListItem({this.quantity, this.product});
}

class Product {
  final double price;

  Product(this.price);
}
