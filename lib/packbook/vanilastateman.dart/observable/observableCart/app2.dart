import 'package:flutter/material.dart';

class MainPageState extends StatefulWidget {
  const MainPageState({super.key});

  @override
  State<MainPageState> createState() => _MainPageStateState();
}

class _MainPageStateState extends State<MainPageState> {
  ValueNotifier<Map<String, CartListItem>> items = ValueNotifier({});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CartPage extends StatefulWidget {
  final ValueNotifier<Map<String, CartListItem>> items;
  const CartPage(
    
      {super.key,
      required this.items,
      required this.onRemoveFromCart,
      required this.onAddToCart});
  final Function(CartListItem) onRemoveFromCart;
  final Function(CartListItem) onAddToCart;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ValueListenableBuilder(
          valueListenable: widget.items,
          builder: (context, items, child) {
            final values = items.values.toList();
            final totalPrice = items.values.fold<double>(
              0,
              (previous, newPr) =>
                  previous + newPr.product!.price * newPr.quantity!,
            );
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: ListView.builder(
                    itemCount: values.length,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemBuilder: ((context, index) {
                      // Using `values` from the builder here instead of _items
                      final item = values[index];
                      return CartListItemView(
                        item: item,
                        onAddToCart: widget.onAddToCart,
                        onRemoveFromCart: widget.onRemoveFromCart,
                      );
                    }),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class CartListItemView  extends StatelessWidget{
  final CartListItem item;
  final onRemoveFromCart;
  final onAddToCart;

  CartListItemView({
    required this.item,
    required this.onRemoveFromCart,
    required this.onAddToCart,
  });
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
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
