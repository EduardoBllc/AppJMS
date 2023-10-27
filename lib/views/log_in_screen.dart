import 'package:app_jms/components/show_snack_bar.dart';
import 'package:app_jms/controllers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/log_in_field.dart';
import 'modals/register_modal.dart';
import '../constants.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  static const String id = '/login';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> loginUser(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: Center(
          child: _loading
              ? CircleAvatar(
                  radius: 150,
                  backgroundColor: Colors.grey[900],
                  child: const CircularLoading(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'JM\nSemi-jóias',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontFamily: 'AbrilFatFace', fontSize: 50),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40),
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
                        backgroundColor: Colors.black,
                        textStyle: kBrandTextStyle(25),
                        elevation: 10,
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 40,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          Provider.of<UserProvider>(context, listen: false)
                              .signInUser(email: email, password: password)
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
                ),
        ),
      ),
    );
  }
}

class CircularLoading extends StatelessWidget {
  const CircularLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
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
    );
  }
}
