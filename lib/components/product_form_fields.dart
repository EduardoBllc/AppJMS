import 'package:flutter/material.dart';

class TextProductFormField extends StatelessWidget {
  const TextProductFormField({
    super.key,
    required this.labelText,
    this.hintText,
    this.onChanged,
    this.flex = 1,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  final String labelText;
  final String? hintText;
  final void Function(Object?)? onChanged;
  final String Function(Object?)? validator;
  final int flex;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
          ),
          onChanged: onChanged,
          autovalidateMode: autovalidateMode,
          validator: validator ??
              (value) {
                if (value != null && value.isEmpty) {
                  return 'Preencha este campo';
                }
                return null;
              },
        ),
      ),
    );
  }
}

class DropdownProductFormField extends StatelessWidget {
  const DropdownProductFormField({
    super.key,
    required this.labelText,
    required this.list,
    required this.onChanged,
    this.flex = 1,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  final String labelText;
  final List list;
  final void Function(Object?) onChanged;
  final String Function(Object?)? validator;
  final int flex;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField(
          items: list
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.name),
                ),
              )
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: labelText,
          ),
          autovalidateMode: autovalidateMode,
          validator: validator ??
              (value) {
                print(value);
                if (value == null) {
                  return 'Selecione este campo';
                }
                return null;
              },
        ),
      ),
    );
  }
}
