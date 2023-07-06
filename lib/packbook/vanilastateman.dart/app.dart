import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Map<String, CartListItem> items = {};

  void addToCart(ProductListItem item) {}

  void removeFromCart(CartListItem item) {}

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ProductsPage extends StatefulWidget {
  final Function(ProductListItem) onAddToCart;
  const ProductsPage({super.key, required this.onAddToCart});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Cartpage extends StatefulWidget {
  final List<CartListItem> items;
  final Function(CartListItem) onRemoveFromCart;
  final Function(CartListItem) onAddToCart;

  const Cartpage({
    super.key,
    required this.items,
    required this.onRemoveFromCart,
    required this.onAddToCart,
  });

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  List<CartListItem> _items = [];
  @override
  void initState() {
    super.initState();
    _items = widget.items;
  }

  void _onremoveFromCart(CartListItem item) {
    setState(() {});
    widget.onRemoveFromCart(item);
  }

  void _addToCart(CartListItem item) {
    setState(() {});
    widget.onAddToCart(item);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CartListItem {}

class ProductListItem {}
