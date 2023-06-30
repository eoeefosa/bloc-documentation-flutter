import 'package:flutter/material.dart';

import '../models/products.dart';

class CartListItemView extends StatelessWidget {
  const CartListItemView({
    super.key,
    required this.product,
    required this.itemnum,
  });

  final InitProduct product;
  final int itemnum;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 350,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: AssetImage(product.imgUrl),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                product.title,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                product.productdescription,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '+',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Text('$itemnum'),
          InkWell(
            onTap: () {},
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '-',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}