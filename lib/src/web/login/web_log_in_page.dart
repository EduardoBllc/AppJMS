import 'package:app_jms/services/firebase_services/authentication_services.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'components/log_in_field.dart';
import '../shared/scaffold_components/show_snack_bar.dart';
import 'register_modal.dart';

class WebLogInPage extends StatefulWidget {
  const WebLogInPage({super.key});

  static const String id = '/login';

  @override
  State<WebLogInPage> createState() => _WebLogInPageState();
}

class _WebLogInPageState extends State<WebLogInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    void loginAttempt() {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _loading = true;
        });
        String email = _emailController.text;
        String password = _passwordController.text;
        FirebaseAuthServices.logInUser(email: email, password: password)
            .then((String? error) {
          if (error != null) {
            setState(() {
              _loading = false;
            });
            late String formattedError;
            if (error.contains('invalid-login-credentials')) {
              formattedError = 'Login ou senha inválidos';
            } else {
              formattedError = error;
            }
            showSnackBar(
                context: context, message: formattedError, color: Colors.red);
          } else {
            Navigator.pushNamed(context, '/menu');
          }
        });
      }
    }

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
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Janete\n',
                            style: TextStyle(
                              fontFamily: 'MonteCarlo',
                              fontSize: 100,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'Semijoias',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Aboreto',
                              color: Colors.black,
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
                              nextFocusNode: passwordFocusNode,
                              autofocus: true,
                              validator: (value) {
                                if (value != null) {
                                  if (!kDebugMode) {
                                    if (value.isEmpty) {
                                      return 'Insira o email!';
                                    }
                                    if (!value.contains('@jms.com')) {
                                      return 'Insira um email válido!';
                                    }
                                  }
                                }
                                return null;
                              },
                            ),
                            LogInFormField(
                              labelText: 'Senha',
                              controller: _passwordController,
                              isPassword: true,
                              focusNode: passwordFocusNode,
                              lastField: true,
                              validator: (value) {
                                if (value != null) {
                                  if (!kDebugMode) {
                                    if (value.isEmpty) {
                                      return 'Insira a senha!';
                                    }
                                    if (value.length < 6) {
                                      return 'A senha deve ter pelo menos 6 caracteres';
                                    }
                                  }
                                }
                                return null;
                              },
                              onFinalSubmit: loginAttempt,
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
                      onPressed: loginAttempt,
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
