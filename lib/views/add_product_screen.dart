import 'package:app_jms/controllers/showcase_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/product_form_fields.dart';
import '../models/product.dart';
import 'package:intl/intl.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey _productFormKey = GlobalKey<FormState>();
  final TextEditingController _boughtDateController = TextEditingController();
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Janete Semijoias'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: _productFormKey,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.82,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: const Text(
                      'Cadastro de Produto',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.65,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const TextProductFormField(
                            labelText: 'Descrição',
                            hintText: 'Breve descrição da peça',
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                DropdownProductFormField(
                                  labelText: 'Categoria',
                                  list: Category.values,
                                  flex: 4,
                                  onChanged: (value) {},
                                ),
                                DropdownProductFormField(
                                  labelText: 'Metal',
                                  list: Metal.values,
                                  flex: 4,
                                  onChanged: (value) {},
                                ),
                                DropdownProductFormField(
                                  labelText: 'Modalidade',
                                  list: Modality.values,
                                  flex: 5,
                                  onChanged: (value) {},
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                DropdownProductFormField(
                                  labelText: 'Fábrica',
                                  list: Provider.of<ShowcaseManager>(context)
                                      .supplierList,
                                  onChanged: (value) {},
                                ),
                                const TextProductFormField(
                                  flex: 2,
                                  labelText: 'Código da Fábrica',
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: const Row(
                              children: [
                                TextProductFormField(labelText: 'Custo'),
                                TextProductFormField(labelText: 'A vista'),
                                TextProductFormField(labelText: 'A prazo'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.date_range,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () async {
                                      _boughtDateController.text =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now()
                                            .subtract(const Duration(days: 60)),
                                        lastDate: DateTime.now(),
                                      ).then((value) {
                                        return dateFormatter.format(value!);
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextFormField(
                                      controller: _boughtDateController,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        labelText: 'Data da compra',
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _boughtDateController.text =
                                            dateFormatter.format(
                                          DateTime.now().subtract(
                                            const Duration(days: 2),
                                          ),
                                        );
                                      },
                                      child: const Text('Ontem'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(onPressed: () {}, child: Text('Cadastrar')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
