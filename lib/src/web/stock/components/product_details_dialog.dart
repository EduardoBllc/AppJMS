import 'package:app_jms/src/shared/default_box_shadow.dart';
import 'package:app_jms/src/shared/styles/default_elevated_button_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/product.dart';
import '../../../../services/controllers/showcase_manager.dart';
import '../../../../services/utils.dart';
import '../../../shared/colors/stock_elements.dart';
import '../../shared/scaffold_components/show_snack_bar.dart';

class ProductDetailsDialog extends StatefulWidget {
  const ProductDetailsDialog({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsDialog> createState() => _ProductDetailsModalState();
}

class _ProductDetailsModalState extends State<ProductDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    TextStyle fieldStyle = TextStyle(
      fontSize: 15,
      color: Colors.grey.shade600,
    );

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: kProductDetailsBackgroundColor,
      insetPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * 0.25,
        vertical: MediaQuery.sizeOf(context).height * 0.05,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: kDefaultBoxShadow(),
              ),
              width: 300,
              height: 300,
              padding: const EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(widget.product.category.path),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: kDefaultBoxShadow(),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  widget.product.description,
                                  style: fieldStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Código: ${widget.product.id}',
                                  style: fieldStyle.copyWith(
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
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
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Modalidade: ${widget.product.modality.name}',
                                            style: fieldStyle,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Categoria: ${widget.product.category.name}',
                                            style: fieldStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Metal: ${widget.product.metal.name}',
                                            style: fieldStyle,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Fornecedor: ${widget.product.supplier.name}',
                                            style: fieldStyle,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Cód Fornecedor: ${widget.product.supplierCode}',
                                            style: fieldStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Data Compra: ${Helper.localDateFormatter(widget.product.boughtDate)}',
                                            style: fieldStyle,
                                            textAlign: TextAlign.end,
                                          ),
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
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Custo\n${Helper.realCurrencyFormatter(widget.product.cost)}',
                                    style: fieldStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'A Vista\n${Helper.realCurrencyFormatter(widget.product.aVista)}',
                                    style: fieldStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'A Prazo\n${Helper.realCurrencyFormatter(widget.product.aPrazo)}',
                                    style: fieldStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 180,
                            child: ElevatedButton(
                              style: kDefaultElevatedButtonStyle(
                                  foregroundColor: Colors.red.shade900),
                              child: const Text('Apagar'),
                              onPressed: () async {
                                String? removeAttempt =
                                    await Provider.of<ShowcaseManager>(context,
                                            listen: false)
                                        .removeProduct(widget.product.id);
                                if (removeAttempt == null) {
                                  if (!mounted) return;
                                  Navigator.pop(context);
                                  showSnackBar(
                                    context: context,
                                    message: 'Peça removida',
                                  );
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
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            height: 40,
                            width: 180,
                            child: ElevatedButton(
                              style: kDefaultElevatedButtonStyle(
                                  foregroundColor: Colors.green.shade900),
                              child: const Text('Vender'),
                              onPressed: () {},
                            ),
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
      ),
    );
  }
}
