import 'package:app_jms/services/controllers/customers_caretaker.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../app/shared/buttons/rounded_material_button.dart';
import '../../../app/shared/scaffold_components/show_snack_bar.dart';
import '../../../app/stock/components/product_form_fields.dart';

class AddCustomerDrawer extends StatefulWidget {
  const AddCustomerDrawer({super.key});

  @override
  State<AddCustomerDrawer> createState() => _AddCustomerDrawerState();
}

class _AddCustomerDrawerState extends State<AddCustomerDrawer> {
  final GlobalKey<FormState> _customerFormKey = GlobalKey<FormState>();
  String name = '';
  String cellphone = '';
  String email = '';
  DateTime birthdate = DateTime.now();
  bool replicateToWhatsapp = false;

  final TextEditingController whatsappController = TextEditingController();

  @override
  void initState() {
    whatsappController.addListener(_applyMask);
    super.initState();
  }

  void _applyMask() {
    String text = whatsappController.text.replaceAll(RegExp(r'\D'), '');
    String maskedText = cellphoneMask.maskText(text);

    whatsappController.value = whatsappController.value.copyWith(
      text: maskedText,
      selection: TextSelection.collapsed(
        offset: maskedText.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width * 0.5,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 30,
                ),
                child: Text(
                  'Cadastro de Cliente',
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
                  key: _customerFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextProductFormField(
                          labelText: 'Nome',
                          icon: const Icon(Icons.person),
                          onChanged: (text) {
                            name = text!;
                          },
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Preencha a descrição da peça';
                            }
                            return null;
                          },
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextProductFormField(
                                labelText: 'Celular',
                                inputFormatters: [cellphoneMask],
                                icon: const Icon(Icons.smartphone),
                                onChanged: (typedCellphone) {
                                  cellphone = typedCellphone!;

                                  if (replicateToWhatsapp) {
                                    whatsappController.text = cellphone;
                                  }
                                },
                                suffix: Tooltip(
                                  message: 'Mesmo para Whatsapp',
                                  child: Checkbox(
                                    value: replicateToWhatsapp,
                                    onChanged: (isChecked) {
                                      setState(() {
                                        replicateToWhatsapp = isChecked!;

                                        if (isChecked == true) {
                                          whatsappController.text = cellphone;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                            Expanded(
                              child: TextProductFormField(
                                labelText: 'Whatsapp',
                                icon: Icon(MdiIcons.whatsapp),
                                controller: whatsappController,
                                readOnly: replicateToWhatsapp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextProductFormField(
                                labelText: 'Email',
                                icon: const Icon(Icons.email),
                                onChanged: (typedEmail) {
                                  email = typedEmail!;
                                },
                                validator: (value) {
                                  if (whatsappController.text == '' && cellphone == '' && email == '') {
                                    return 'Preencha algum dos contatos';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 2,
                              child: DateTimeFormField(
                                mode: DateTimeFieldPickerMode.date,
                                initialValue: DateTime.now().toLocal(),
                                dateFormat: DateFormat("dd/MM/yyyy"),
                                firstDate: DateTime.now().subtract(const Duration(days: 60)),
                                lastDate: DateTime.now(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade700,
                                ),
                                onChanged: (date) {
                                  if (date != null) {
                                    birthdate = date.toLocal();
                                  }
                                },
                                validator: (date) {
                                  if (date == null) {
                                    return 'Insira a data de compra';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Data de nascimento',
                                  icon: const Icon(Icons.today),
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
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: TextProductFormField(
                          labelText: 'Observação',
                          icon: Icon(Icons.edit_note),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: RoundedMaterialButton(
                  elevation: 2,
                  textStyle: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 30,
                  ),
                  color: Colors.white,
                  text: 'Cadastrar',
                  onTap: () async {
                    if (_customerFormKey.currentState!.validate()) {
                      if (!mounted) return;
                      String? customerCreated =
                          await Provider.of<CustomersCaretaker>(context, listen: false).createCustomer(
                        name: name,
                        birthdate: birthdate,
                        whatsapp: whatsappController.text,
                      );
                      Navigator.pop(context);
                      if (customerCreated == null) {
                        showSnackBar(
                          context: context,
                          message: 'Cliente cadastrado',
                        );
                      } else {
                        showSnackBar(
                          color: Colors.red,
                          context: context,
                          message: 'Erro ao cadastrar cliente',
                        );
                      }
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
