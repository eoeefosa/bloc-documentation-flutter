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

class CartListItem{}