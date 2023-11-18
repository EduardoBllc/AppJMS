import 'package:app_jms/services/helpers.dart';
import 'package:app_jms/src/shared/modals/default_stack_modal.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';

class ProductModal extends StatelessWidget {
  const ProductModal({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    TextStyle fieldStyle = TextStyle(
      fontSize: 16,
      color: Colors.grey.shade600,
    );

    return DefaultStackModal(
      backgroundColor: const Color(0xFFE6E6E6),
      maxHeight: MediaQuery.sizeOf(context).height * 0.81,
      bodyWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              width: 230,
              height: 230,
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(product.category.path),
              ),
            ),
          ),
          Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Text(
                          product.description,
                          style: fieldStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Código: ${product.code}',
                          style: fieldStyle.copyWith(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 2,
                    indent: 40,
                    endIndent: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Modali.: ${product.modality.name}',
                                style: fieldStyle,
                              ),
                              Text(
                                'Categoria: ${product.category.name}',
                                style: fieldStyle,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Metal: ${product.metal.name}',
                                style: fieldStyle,
                              ),
                              Text(
                                'Compra: ${Helper.localDateFormatter(product.boughtDate)}',
                                style: fieldStyle,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Forn.: ${product.supplier.name}',
                                style: fieldStyle,
                              ),
                              Text(
                                'Cód. Forn.: ${product.supplierCode}',
                                style: fieldStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 2,
                    indent: 40,
                    endIndent: 40,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'Preços',
                        style: fieldStyle.copyWith(fontSize: 18),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Custo\n${Helper.realCurrencyFormatter(product.cost)}',
                        style: fieldStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Vista\n${Helper.realCurrencyFormatter(product.aVista)}',
                        style: fieldStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Prazo\n${Helper.realCurrencyFormatter(product.aPrazo)}',
                        style: fieldStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundedMaterialButton(
                          color: Colors.red.shade300,
                          text: 'Apagar',
                          onTap: () {},
                        ),
                        RoundedMaterialButton(
                          color: Colors.green.shade300,
                          text: 'Vender',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedMaterialButton extends StatelessWidget {
  const RoundedMaterialButton({
    super.key,
    required this.color,
    required this.text,
    required this.onTap,
  });

  final Color color;
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      onPressed: onTap,
      elevation: 1,
      color: color.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.white.withOpacity(0.4),
          width: 2,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
