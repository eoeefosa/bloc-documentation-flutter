import 'package:flutter/material.dart';

import '../models/products.dart';

class ProductListItemView extends StatelessWidget {
  const ProductListItemView({super.key, required this.product});
  final InitProduct product;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
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
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
          )
        ],
      ),
    );
  }
}
