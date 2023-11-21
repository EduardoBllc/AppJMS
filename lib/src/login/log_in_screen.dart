import 'package:flutter/material.dart';
import '../../services/firebase_services.dart';
import 'components/log_in_field.dart';
import '../shared/scaffold_components/show_snack_bar.dart';
import 'register_modal.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  static const String id = '/login';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseServices _services = FirebaseServices();
  bool _loading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: !_loading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Janete Maria\n',
                            style: TextStyle(
                              fontFamily: 'MonteCarlo',
                              fontSize: 75,
                              color: Colors.black,
                            ),
                          ),
                          const TextSpan(
                            text: 'Semi',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Aboreto',
                              color: Colors.grey,
                            ),
                          ),
                          TextSpan(
                            text: 'Jóias',
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Aboreto',
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.end,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: 350,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            LogInFormField(
                              labelText: 'Email',
                              controller: _emailController,
                              validator: (value) {
                                if (value != null) {
                                  if (value.isEmpty) {
                                    return 'Insira o email!';
                                  }
                                  if (!value.contains('@jms.com')) {
                                    return 'Insira um email válido!';
                                  }
                                }
                                return null;
                              },
                            ),
                            LogInFormField(
                              labelText: 'Senha',
                              controller: _passwordController,
                              isPassword: true,
                              validator: (value) {
                                if (value != null) {
                                  if (value.isEmpty) {
                                    return 'Insira a senha!';
                                  }
                                  if (value.length < 6) {
                                    return 'A senha deve ter pelo menos 6 caracteres!';
                                  }
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.black,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          _services
                              .logInUser(email: email, password: password)
                              .then((String? error) {
                            if (error != null) {
                              setState(() {
                                _loading = false;
                              });
                              late String formattedError;
                              if (error.contains('INVALID_LOGIN_CREDENTIALS')) {
                                formattedError = 'Login ou senha inválidos';
                              } else {
                                formattedError = error;
                              }
                              showSnackBar(
                                  context: context,
                                  message: formattedError,
                                  color: Colors.red);
                            } else {
                              Navigator.pushNamed(context, '/main');
                            }
                          });
                        }
                      },
                      onLongPress: () {
                        if (_formKey.currentState!.validate()) {
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (_) => RegisterModal(
                              userEmail: email,
                              userPassword: password,
                            ),
                          );
                        }
                      },
                      child: const Text('Entrar'),
                    ),
                  ],
                )
              : const CircleAvatar(
                  radius: 150,
                  backgroundColor: Colors.black,
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: SizedBox(
                            width: 180,
                            height: 180,
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: SizedBox(
                            width: 180,
                            height: 180,
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                              strokeWidth: 2,
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
