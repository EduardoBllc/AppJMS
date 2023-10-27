import 'package:app_jms/components/log_in_field.dart';
import 'package:app_jms/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/user_provider.dart';

class RegisterModal extends StatefulWidget {
  const RegisterModal({
    super.key,
    required this.userEmail,
    required this.userPassword,
  });

  final String userEmail;
  final String userPassword;

  @override
  State<RegisterModal> createState() => _RegisterModalState();
}

class _RegisterModalState extends State<RegisterModal> {
  final TextEditingController _masterKeyController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: const Color(0xff737373),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Cadastrar novo usuário',
                    style: kBrandTextStyle(30),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Column(
                      children: [
                        LogInFormField(
                          labelText: 'Chave mestra',
                          controller: _masterKeyController,
                          isPassword: true,
                          validator: (value) {
                            if (value != null) {
                              if (value.isEmpty) {
                                return 'Insira a chave mestra!';
                              } else if (value != 'dadolu') {
                                return 'Chave mestra incorreta!';
                              }
                            }
                            return null;
                          },
                        ),
                        LogInFormField(
                          labelText: 'Nome de usuário',
                          controller: _usernameController,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Insira o nome de usuário!';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      textStyle: kBrandTextStyle(22),
                      elevation: 10,
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                    ),
                    onPressed: () {
                      String username = _usernameController.text;
                      if (_formKey.currentState!.validate()) {
                        Provider.of<UserProvider>(context, listen: false)
                            .createNewUser(
                          username,
                          widget.userEmail,
                          widget.userPassword,
                        );
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/main');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Usuário cadastrado com sucesso!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    child: const Text('Cadastrar'),
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
