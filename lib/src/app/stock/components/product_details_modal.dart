import 'package:app_jms/services/controllers/showcase_manager.dart';
import 'package:app_jms/services/utils.dart';
import 'package:app_jms/src/shared/colors/stock_elements.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/stock/product.dart';
import '../../../web/shared/modals/default_stack_modal.dart';
import '../../../web/shared/scaffold_components/show_snack_bar.dart';
import '../../shared/buttons/rounded_material_button.dart';

class ProductDetailsModal extends StatefulWidget {
  const ProductDetailsModal({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsModal> createState() => _ProductDetailsModalState();
}

class _ProductDetailsModalState extends State<ProductDetailsModal> {
  @override
  Widget build(BuildContext context) {
    TextStyle fieldStyle = TextStyle(
      fontSize: 16,
      color: Colors.grey.shade600,
    );

    return DefaultStackModal(
      backgroundColor: kProductDetailsBackgroundColor,
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
                child: Image.asset(widget.product.category.path),
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
                          widget.product.description,
                          style: fieldStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Código: ${widget.product.id}',
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
                                'Modali.: ${widget.product.modality.name}',
                                style: fieldStyle,
                              ),
                              Text(
                                'Categoria: ${widget.product.category.name}',
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
                                'Metal: ${widget.product.metal.name}',
                                style: fieldStyle,
                              ),
                              Text(
                                'Compra: ${Helper.localDateFormatter(widget.product.boughtDate)}',
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
                                'Forn.: ${widget.product.supplier.name}',
                                style: fieldStyle,
                              ),
                              Text(
                                'Cód. Forn.: ${widget.product.supplierCode}',
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
                        'Custo\n${Helper.realCurrencyFormatter(widget.product.cost)}',
                        style: fieldStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Vista\n${Helper.realCurrencyFormatter(widget.product.aVista)}',
                        style: fieldStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Prazo\n${Helper.realCurrencyFormatter(widget.product.aPrazo)}',
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
                        BorderedMaterialButton(
                          color: Colors.red.shade300,
                          text: 'Apagar',
                          onTap: () async {
                            String? removeAttempt =
                                await Provider.of<ShowcaseManager>(context,
                                        listen: false)
                                    .removeProduct(widget.product.id);
                            if (removeAttempt == null) {
                              if (mounted) {
                                Navigator.pop(context);
                                showSnackBar(
                                  context: context,
                                  message: 'Peça removida',
                                );
                              }
                            } else {
                              if (mounted) {
                                Navigator.pop(context);
                                showSnackBar(
                                  context: context,
                                  message: 'Erro ao remover peça',
                                );
                              }
                            }
                          },
                        ),
                        BorderedMaterialButton(
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
