import 'package:blocdocplay/packbook/candystoreapp/initapp/models/products.dart';
import 'package:flutter/material.dart';

import '../components/CartListItemView.dart';

class CartscreenInit extends StatelessWidget {
  const CartscreenInit({super.key, required this.item});
  final List<InitProduct> item;

  @override
  Widget build(BuildContext context) {
    int itemnum = 0;
    int price = 15;
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) {
          InitProduct product = item[index];
          return CartListItemView(product: product, itemnum: itemnum);
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
        ),
        itemCount: item.length,
      ),
      bottomNavigationBar: Container(
        color: Colors.brown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total (${item.length}) :"),
            Text('\$ $price'),
          ],
        ),
      ),
    );
  }
}
