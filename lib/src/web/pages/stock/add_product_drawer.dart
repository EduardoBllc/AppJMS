import 'dart:developer';
import 'package:app_jms/constants.dart';
import 'package:app_jms/models/supplier.dart';
import 'package:app_jms/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import '../../../../models/product.dart';
import '../../../../services/controllers/showcase_manager.dart';
import '../../../app/shared/buttons/rounded_material_button.dart';
import '../../../app/shared/scaffold_components/show_snack_bar.dart';
import 'components/product_form_fields.dart';

class AddProductDrawer extends StatefulWidget {
  const AddProductDrawer({super.key});

  static const String id = '/menu/add';

  @override
  State<AddProductDrawer> createState() => _AddProductDrawerState();
}

class _AddProductDrawerState extends State<AddProductDrawer> {
  String description = '', supplierCode = '';

  double cost = 0.0, vista = 0.0, prazo = 0.0;

  late DateTime boughtDate;

  final CurrencyTextInputFormatter moneyFormatter = CurrencyTextInputFormatter(
      locale: 'pt-br', decimalDigits: 2, symbol: 'R\$');

  late Supplier supplier;
  late Category category;
  late Metal metal;
  late Modality modality;

  final GlobalKey<FormState> _productFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width * 0.4,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.sizeOf(context).height * 0.1),
                child: const Text(
                  'Cadastro de Peças',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Aboreto',
                  ),
                ),
              ),
              Expanded(
                child: Form(
                  key: _productFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextProductFormField(
                              labelText: 'Descrição',
                              hintText: 'Breve descrição da peça',
                              icon: const Icon(Icons.text_fields_outlined),
                              onChanged: (text) {
                                description = text!;
                              },
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Preencha a descrição da peça';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: DropdownProductFormField<Category>(
                              labelText: 'Categoria',
                              list: Category.values,
                              icon: const Icon(Icons.category_outlined),
                              onSelected: (newCategory) {
                                category = newCategory!;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Insira a categoria';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: DropdownProductFormField<Metal>(
                              labelText: 'Metal',
                              list: Metal.values,
                              icon: const Icon(Icons.texture_outlined),
                              onSelected: (newMetal) {
                                metal = newMetal!;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Insira o metal';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: DropdownProductFormField<Modality>(
                              labelText: 'Modalidade',
                              list: Modality.values,
                              icon: const Icon(Icons.family_restroom_outlined),
                              flex: 5,
                              onSelected: (newModality) {
                                modality = newModality!;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Insira a modalidade';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: DropdownProductFormField<Supplier>(
                              icon: const Icon(Icons.factory_outlined),
                              labelText: 'Fábrica',
                              list: Provider.of<ShowcaseManager>(context)
                                  .supplierList,
                              onSelected: (selectedSupplier) {
                                supplier = selectedSupplier!;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Insira a fábrica';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextProductFormField(
                              labelText: 'Código Fábrica',
                              icon: const Icon(Icons.vpn_key),
                              onChanged: (typedCode) {
                                supplierCode = typedCode!;
                              },
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Preencha o código da fábrica';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: DateTimeFormField(
                              mode: DateTimeFieldPickerMode.date,
                              initialDate: DateTime.now(),
                              dateFormat: DateFormat('dd/MM/yyyy'),
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 60)),
                              lastDate: DateTime.now(),
                              dateTextStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Data de compra',
                                icon: const Icon(Icons.date_range_outlined),
                                labelStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                                iconColor: kColorScheme.onPrimary,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kColorScheme.onPrimary,
                                  ),
                                ),
                              ),
                              onDateSelected: (date) {
                                boughtDate = date;
                              },
                              validator: (date) {
                                if (date == null) {
                                  return 'Insira a data de compra';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextProductFormField(
                              labelText: 'Custo',
                              icon: const Icon(Icons.attach_money_outlined),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Preencha o custo';
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                moneyFormatter,
                              ],
                              onChanged: (value) {
                                cost = Helper.autoFormatToCurrency(value);
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextProductFormField(
                              labelText: 'A vista',
                              icon: const Icon(Icons.payments_outlined),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Preencha o preço a vista';
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                moneyFormatter,
                              ],
                              onChanged: (value) {
                                vista = Helper.autoFormatToCurrency(value);
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextProductFormField(
                              labelText: 'A prazo',
                              icon: const Icon(Icons.credit_card_outlined),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Preencha o preço a prazo';
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                moneyFormatter,
                              ],
                              onChanged: (value) {
                                prazo = Helper.autoFormatToCurrency(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height * 0.1),
                child: RoundedMaterialButton(
                  elevation: 3,
                  textStyle: TextStyle(
                    color: kColorScheme.onPrimary,
                    fontSize: 30,
                  ),
                  color: kCreamColor,
                  text: 'Cadastrar',
                  onTap: () {
                    if (_productFormKey.currentState!.validate()) {
                      Provider.of<ShowcaseManager>(context, listen: false)
                          .registerProduct(
                        supplier: supplier,
                        supplierCode: supplierCode,
                        category: category,
                        description: description,
                        cost: cost / 100,
                        aVista: vista / 100,
                        aPrazo: prazo / 100,
                        boughtDate: boughtDate,
                      );
                      Navigator.pop(context);
                      showSnackBar(
                          context: context, message: 'Peça cadastrada');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
