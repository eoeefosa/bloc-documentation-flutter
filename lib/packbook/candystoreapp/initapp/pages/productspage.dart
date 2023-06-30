import 'package:blocdocplay/packbook/candystoreapp/initapp/components/productListItemview.dart';
import 'package:flutter/material.dart';

import '../models/products.dart';

class ProductsPageInit extends StatelessWidget {
  const ProductsPageInit({super.key, required this.products});

  final List<InitProduct> products;

  @override
  Widget build(BuildContext context) {
    int productnumber = 0;
    return Scaffold(
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 40,
          );
        },
        itemBuilder: (context, index) => ProductListItemView(
          product: products[index],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
            children: productnumber == 0
                ? [
                    const Icon(
                      Icons.shopping_cart_rounded,
                      size: 40,
                    )
                  ]
                : [
                    Positioned(
                        top: 0,
                        child: CircleAvatar(
                          child: Text('$productnumber'),
                        )),
                    const Icon(
                      Icons.shopping_cart_rounded,
                      size: 40,
                    )
                  ]),
      ),
    );
  }
}
