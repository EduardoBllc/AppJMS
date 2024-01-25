import 'package:app_jms/constants.dart';
import 'package:app_jms/src/shared/colors/stock_elements.dart';
import 'package:app_jms/src/web/stock/components/product_details_dialog.dart';
import 'package:flutter/material.dart';
import '../../../../models/product.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: MaterialButton(
        color: kProductsBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return ProductDetailsDialog(
                product: product,
              );
            },
          );
        },
        child: Column(
          children: [
            Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              child: Container(
                width: 130,
                height: 130,
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(product.category.path),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: kColorScheme.onBackground,
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3f000000),
                      blurRadius: 5,
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product.id.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        product.description,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      Text(
                        '${product.modality.name} - ${product.supplier}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconTextColumn extends StatelessWidget {
  const IconTextColumn({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
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
