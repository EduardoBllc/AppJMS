import 'dart:developer';
import 'package:app_jms/constants.dart';
import 'package:app_jms/models/supplier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import '../../models/product.dart';
import '../../services/controllers/showcase_manager.dart';
import '../shared/components/show_snack_bar.dart';
import 'components/product_form_fields.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  static const String id = '/add';

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String description = '', supplierCode = '';

  double cost = 0.0, vista = 0.0, prazo = 0.0;

  late DateTime boughtDate;

  final CurrencyTextInputFormatter moneyFormatter = CurrencyTextInputFormatter(
      locale: 'pt-br', decimalDigits: 2, symbol: 'R\$');

  late Supplier supplier;
  late Category category;
  late Metal metal;
  late Modality modality;

  final GlobalKey _productFormKey = GlobalKey<FormState>();

  double autoFormatToCurrency(String? value) {
    if (value!.isNotEmpty) {
      late String formattedValue = value.split('\$')[1].replaceAll(',', '.');
      if (formattedValue.length > 5) {
        for (int i = 2; i < formattedValue.length; i += 3) {
          formattedValue = formattedValue.replaceFirst('.', '');
        }
      }
      try {
        return double.parse(formattedValue);
      } catch (e) {
        // print(e);
        return 0.0;
      }
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints.expand(
              height: MediaQuery.sizeOf(context).height * 0.9,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Cadastro de Produtos',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  constraints: BoxConstraints.expand(
                    height: MediaQuery.sizeOf(context).height * 0.75,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Form(
                    key: _productFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextProductFormField(
                          labelText: 'Descrição',
                          hintText: 'Breve descrição da peça',
                          icon: const Icon(Icons.text_fields_outlined),
                          onChanged: (text) {
                            description = text!;
                          },
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Preencha a descrição do produto';
                            }
                            return null;
                          },
                        ),
                        DoubleFieldRow(
                          child1: DropdownProductFormField<Category>(
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
                          child2: DropdownProductFormField<Metal>(
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
                        DoubleFieldRow(
                          child1: DropdownProductFormField<Modality>(
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
                          child2: DropdownProductFormField<Supplier>(
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
                        DoubleFieldRow(
                          child1: TextProductFormField(
                            flex: 2,
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
                          child2: TextProductFormField(
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
                              cost = autoFormatToCurrency(value);
                            },
                          ),
                        ),
                        DoubleFieldRow(
                          child1: TextProductFormField(
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
                              vista = autoFormatToCurrency(value);
                            },
                          ),
                          child2: TextProductFormField(
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
                                prazo = autoFormatToCurrency(value);
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.5,
                              child: DateTimeFormField(
                                mode: DateTimeFieldPickerMode.date,
                                initialDate: DateTime.now(),
                                dateFormat: DateFormat('dd/MM/yyyy'),
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 60)),
                                lastDate: DateTime.now(),
                                dateTextStyle: const TextStyle(fontSize: 16),
                                decoration: const InputDecoration(
                                  labelText: 'Data de compra',
                                  icon: Icon(Icons.date_range_outlined),
                                ),
                                onDateSelected: (date) {
                                  boughtDate = date;
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextButton(
                            onPressed: () {
                              log(description);
                              log(category.name);
                              log(metal.name);
                              log(modality.name);
                              log(supplier.name);
                              log(supplierCode.toString());
                              log('$cost');
                              log('$vista');
                              log('$prazo');
                              log(boughtDate.toString());

                              Provider.of<ShowcaseManager>(context,
                                      listen: false)
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
                                  context: context,
                                  message: 'Produto cadastrado');
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 40,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black87,
                              ),
                              child: Text(
                                'Cadastrar',
                                style: kBrandTextStyle(
                                  20,
                                  color: Colors.amber[200],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
