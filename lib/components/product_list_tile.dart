import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        tileColor: Colors.grey[300],
        title: Text(product.description),
        subtitle: Text(
            '${product.category.name} - ${product.metal.name}\n${product.modality.name}'),
        isThreeLine: true,
        trailing: Column(
          children: [
            Text('${product.cost}'),
            Text('${product.upfrontValue}'),
            Text('${product.deferredValue}'),
          ],
        ),
      ),
    );
  }
}