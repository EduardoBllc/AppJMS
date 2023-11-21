import 'package:app_jms/constants.dart';
import 'package:flutter/material.dart';
import '../../../models/product.dart';
import '../../../services/helpers.dart';
import '../components/product_details_modal.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: MaterialButton(
        color: const Color(0xFFD9D9D9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(5),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return ProductDetailsModal(product: product);
            },
          );
        },
        child: Row(
          children: [
            Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              child: Container(
                width: 85,
                height: 85,
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(product.category.path),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Material(
                color: kColorScheme.onBackground,
                borderRadius: BorderRadius.circular(8),
                elevation: 3,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  height: 85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                '${product.supplier.name} - ${product.modality.name}',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 60,
                        width: 1.5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.25,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconTextRow(
                              icon: Icons.attach_money_outlined,
                              text: Helper.realCurrencyFormatter(product.cost),
                            ),
                            IconTextRow(
                              icon: Icons.payments_outlined,
                              text:
                                  Helper.realCurrencyFormatter(product.aVista),
                            ),
                            IconTextRow(
                              icon: Icons.credit_card_outlined,
                              text:
                                  Helper.realCurrencyFormatter(product.aPrazo),
                            ),
                          ],
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
