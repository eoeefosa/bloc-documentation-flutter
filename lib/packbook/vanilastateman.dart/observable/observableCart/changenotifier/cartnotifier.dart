import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CartNotifier cartNotifier = CartNotifier();
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CartPage extends StatefulWidget {
  final CartNotifier cartNotifier;
  const CartPage({super.key, required this.cartNotifier});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CartNotifier extends ChangeNotifier {
  final Map<String, CartListItem> _items = {};
  final double _totalPrice = 0;
  final int _totalItems = 0;

  List<CartListItem> get items => _items.values.toList();
  double get totalPrice => _totalPrice;
  int get totalItems => _totalItems;

  void addToCart(ProductListItem item) {
    notifyListeners();
  }

  void removeFromCart(CartListItem item) {
    notifyListeners();
  }
}

class ProductListItem {}

class CartListItem {
  final Product? product;
  final num? quantity;

  CartListItem({this.quantity, this.product});
}

class Product {
  final double price;

  Product(this.price);
}



// class CartNotifier extends ChangeNotifier {
//   final Map<String, CartListItem> _items = {};
//   double _totalPrice = 0;
//   int _totalItems = 0;

//   List<CartListItem> get items => _items.values.toList();
//   double get totalPrice => _totalPrice;
//   int get totalItems => _totalItems;

//   void addToCart(ProductListItem item) {
//     // Check if the item already exists in the cart
//     if (_items.containsKey(item.id)) {
//       // Increment the quantity of the existing item
//       _items[item.id]!.quantity++;
//     } else {
//       // Add a new item to the cart with quantity 1
//       _items[item.id] = CartListItem(
//         id: item.id,
//         name: item.name,
//         price: item.price,
//         quantity: 1,
//       );
//     }
//     // Update the total price and total items
//     _totalPrice += item.price;
//     _totalItems++;
//     // Notify the listeners
//     notifyListeners();
//   }

//   void removeFromCart(CartListItem item) {
//     // Check if the item exists in the cart
//     if (_items.containsKey(item.id)) {
//       // Decrement the quantity of the existing item
//       _items[item.id]!.quantity--;
//       // If the quantity becomes zero, remove the item from the cart
//       if (_items[item.id]!.quantity == 0) {
//         _items.remove(item.id);
//       }
//       // Update the total price and total items
//       _totalPrice -= item.price;
//       _totalItems--;
//       // Notify the listeners
//       notifyListeners();
//     }
//   }
// }