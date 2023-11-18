import 'package:flutter/material.dart';
import '../../../constants.dart';

class LogInFormField extends StatelessWidget {
  const LogInFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.isPassword = false,
    this.validator,
  });

  final String labelText;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.black,
        ),
        controller: controller,
        decoration: InputDecoration(
          border: kGoldenFieldBorder,
          enabledBorder: kGoldenFieldBorder,
          focusedBorder: kGoldenFieldBorder,
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black),
        ),
        textAlign: TextAlign.center,
        obscureText: isPassword,
        validator: validator,
      ),
    );
  }
}
