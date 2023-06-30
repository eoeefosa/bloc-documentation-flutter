import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CartNotifier cartNotifier = CartNotifier();
  @override
  void initState() {
    super.initState();
    cartNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    cartNotifier.dispose();
    super.dispose();
  }

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
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cartNotifier.addListener(_updateCart);
  }

  @override
  void dispose() {
    widget.cartNotifier.removeListener(_updateCart);
    super.dispose();
  }

  void _updateCart() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(itemBuilder: (context, index) {
    // return CartListItemView(
    //   item: item,
    //   onRemoveFromCart: widget.cartNotifier.removeFromCart,
    //   onAddToCart: (item)=>widget.cartNotifier.addToCart(item.product),
    // );
    // });

    // or
    return ListenableBuilder(
        listenable: widget.cartNotifier,
        builder: (context, _) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: widget.cartNotifier.items.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartNotifier.items[index];
                      return CartListItemView(
                          item: item, cartNotifier: widget.cartNotifier);
                    }),
              ),
            ],
          );
        });
  }
}

// class CartListItemView extends StatelessWidget {
//   final CartListItem item;
//   final onRemoveFromCart;
//   final onAddToCart;

//   const CartListItemView({
//     super.key,
//     required this.item,
//     required this.onRemoveFromCart,
//     required this.onAddToCart,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

class CartListItemView extends StatelessWidget {
  final CartListItem item;
  final CartNotifier cartNotifier;

  const CartListItemView({
    super.key,
    required this.item,
    required this.cartNotifier,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
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