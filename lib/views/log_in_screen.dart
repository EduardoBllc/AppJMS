import 'package:flutter/material.dart';
import '../components/log_in_field.dart';
import 'modals/register_modal.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  static const String id = '/';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'JM\nSemi-jóias',
              textAlign: TextAlign.start,
              style: TextStyle(fontFamily: 'AbrilFatFace', fontSize: 50),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    LogInFormField(
                      labelText: 'Email',
                      controller: _emailController,
                    ),
                    LogInFormField(
                      labelText: 'Senha',
                      controller: _passwordController,
                      isPassword: true,
                    ),
                  ],
                ),
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
                  horizontal: 40,
                ),
              ),
              onPressed: () {
                String email = _emailController.text;
                String password = _passwordController.text;
                Navigator.pushNamed(context, '/main');
              },
              onLongPress: () {
                String email = _emailController.text;
                String password = _passwordController.text;
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (_) => RegisterModal(userEmail: email, userPassword: password),
                );
              },
              child: const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
