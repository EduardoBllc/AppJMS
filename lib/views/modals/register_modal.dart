import 'package:app_jms/components/log_in_field.dart';
import 'package:app_jms/constants.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color(0xff737373),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                      ),
                      LogInFormField(
                        labelText: 'Nome de usuário',
                        controller: _usernameController,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'AbrilFatFace',
                      fontSize: 25,
                    ),
                    elevation: 10,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                  ),
                  onPressed: () {
                    //TODO implement register
                  },
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
