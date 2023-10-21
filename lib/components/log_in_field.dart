import 'package:flutter/material.dart';
import '../constants.dart';

class LogInFormField extends StatelessWidget {
  const LogInFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.isPassword = false,
  });

  final String labelText;
  final TextEditingController controller;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: kGoldenFieldBorder,
          focusedBorder: kGoldenFieldBorder,
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black),
        ),
        textAlign: TextAlign.center,
        obscureText: isPassword,
      ),
    );
  }
}
