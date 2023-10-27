import 'package:app_jms/constants.dart';
import 'package:app_jms/controllers/showcase_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/product_form_fields.dart';
import '../models/product.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  static const String id = '/add';

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey _productFormKey = GlobalKey<FormState>();
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JM Semijoias'),
      ),
      body: SafeArea(
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
                          const TextProductFormField(
                            labelText: 'Descrição',
                            hintText: 'Breve descrição da peça',
                            icon: Icon(Icons.text_fields_outlined),
                          ),
                          DoubleFieldRow(
                            child1: DropdownProductFormField(
                              labelText: 'Categoria',
                              list: Category.values,
                              icon: const Icon(Icons.category_outlined),
                              onChanged: (value) {},
                            ),
                            child2: DropdownProductFormField(
                              labelText: 'Metal',
                              list: Metal.values,
                              icon: const Icon(Icons.texture_outlined),
                              onChanged: (value) {},
                            ),
                          ),
                          DoubleFieldRow(
                            child1: DropdownProductFormField(
                              labelText: 'Modalidade',
                              list: Modality.values,
                              icon: const Icon(Icons.family_restroom_outlined),
                              flex: 5,
                              onChanged: (value) {},
                            ),
                            child2: DropdownProductFormField(
                              icon: const Icon(Icons.factory_outlined),
                              labelText: 'Fábrica',
                              list: Provider.of<ShowcaseManager>(context)
                                  .supplierList,
                              onChanged: (value) {},
                            ),
                          ),
                          const DoubleFieldRow(
                            child1: TextProductFormField(
                              flex: 2,
                              labelText: 'Código Fábrica',
                              icon: Icon(Icons.vpn_key),
                            ),
                            child2: TextProductFormField(
                              labelText: 'Custo',
                              icon: Icon(Icons.attach_money_outlined),
                            ),
                          ),
                          const DoubleFieldRow(
                            child1: TextProductFormField(
                              labelText: 'A vista',
                              icon: Icon(
                                Icons.payments_outlined,
                              ),
                            ),
                            child2: TextProductFormField(
                              labelText: 'A prazo',
                              icon: Icon(Icons.credit_card_outlined),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                child: DateTimeFormField(
                                  mode: DateTimeFieldPickerMode.date,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now().subtract(
                                    const Duration(days: 60),
                                  ),
                                  lastDate: DateTime.now(),
                                  decoration: const InputDecoration(
                                    labelText: 'Data de compra',
                                    icon: Icon(Icons.date_range_outlined),
                                  ),
                                  dateFormat: DateFormat('dd/MM/yyyy'),
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Container(
                              margin: const EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 40),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black87,
                              ),
                              child: Text(
                                'Cadastrar',
                                style: kBrandTextStyle(20, color: Colors.white),
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
      ),
    );
  }
}

class DoubleFieldRow extends StatelessWidget {
  const DoubleFieldRow({super.key, required this.child1, required this.child2});

  final Widget child1;
  final Widget child2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.4,
          child: child1,
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.4,
          child: child2,
        ),
      ],
    );
  }
}
