import 'package:flutter/material.dart';
import '../../../../constants.dart';

class LogInFormField extends StatelessWidget {
  const LogInFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.isPassword = false,
    this.validator,
    this.focusNode,
    this.nextFocusNode,
    this.autofocus = false,
    this.lastField = false,
    this.onFinalSubmit,
  });

  final String labelText;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool autofocus;
  final bool lastField;
  final void Function()? onFinalSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.black,
        ),
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
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
        onFieldSubmitted: (value) {
          if (lastField == true) {
            onFinalSubmit!();
          } else if (nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
        },
      ),
    );
  }
}
