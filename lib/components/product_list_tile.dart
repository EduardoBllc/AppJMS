import 'package:app_jms/constants.dart';
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
      child: Material(
        color: kColorScheme.onBackground,
        // const Color(0xFFE3E3E3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(product.category.path),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.description,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      Text(
                        '${product.category.name} - ${product.metal.name} - ${product.modality.name}',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.25,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconTextRow(
                      icon: Icons.attach_money_outlined,
                      text: 'R\$${product.cost.toStringAsFixed(2)}',
                    ),
                    const SizedBox(height: 5),
                    IconTextRow(
                      icon: Icons.payments_outlined,
                      text: 'R\$${product.aVista.toStringAsFixed(2)}',
                    ),
                    const SizedBox(height: 5),
                    IconTextRow(
                      icon: Icons.credit_card_outlined,
                      text: 'R\$${product.aPrazo.toStringAsFixed(2)}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconTextRow extends StatelessWidget {
  const IconTextRow({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.grey[700],
        ),
        Text(
          text,
          style: TextStyle(color: Colors.black.withOpacity(0.7)),
        ),
      ],
    );
  }
}
