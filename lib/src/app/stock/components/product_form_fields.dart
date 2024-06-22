import 'package:app_jms/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../models/utils/mixins/with_name.dart';

class TextProductFormField extends StatelessWidget {
  const TextProductFormField({
    super.key,
    required this.labelText,
    this.hintText,
    this.onChanged,
    this.flex = 1,
    this.validator,
    this.required = false,
    this.readOnly = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.icon,
    this.inputFormatters,
    this.decoration,
    this.validationRefusedMessage,
    this.suffix,
    this.controller,
  });

  final String labelText;
  final String? hintText;
  final void Function(String?)? onChanged;
  final bool required;
  final String? Function(String?)? validator;
  final int flex;
  final AutovalidateMode autovalidateMode;
  final Icon? icon;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? decoration;
  final String? validationRefusedMessage;
  final bool readOnly;
  final Widget? suffix;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      style: TextStyle(
        color: Colors.grey.shade700,
      ),
      validator: validator ??
          (required
              ? (value) {
                  if (value != null && value.isEmpty) {
                    return validationRefusedMessage ?? 'Preencha este campo';
                  }
                  return null;
                }
              : null),
      decoration: decoration ??
          InputDecoration(
            labelText: labelText,
            hintText: hintText,
            icon: icon,
            suffixIcon: suffix,
            labelStyle: TextStyle(
              color: Colors.grey.shade700,
            ),
            iconColor: kColorScheme.onPrimary,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade700,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: kColorScheme.onPrimary,
              ),
            ),
          ),
    );
  }
}

class DropdownProductFormField<T extends WithName> extends StatelessWidget {
  const DropdownProductFormField({
    super.key,
    required this.labelText,
    required this.list,
    required this.onSelected,
    this.flex = 1,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.icon,
  });

  final String labelText;
  final List<T> list;
  final void Function(T?)? onSelected;
  final String? Function(T?)? validator;
  final int flex;
  final AutovalidateMode autovalidateMode;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      items: list
          .map(
            (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(
                item.name,
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
          )
          .toList(),
      autovalidateMode: autovalidateMode,
      onChanged: onSelected,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey.shade700,
        ),
        icon: icon,
        iconColor: kColorScheme.onPrimary,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade700,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: kColorScheme.onPrimary,
          ),
        ),
      ),
      validator: validator ??
          (value) {
            if (value == null) {
              return 'Selecione este campo';
            }
            return null;
          },
    );
  }
}

class DoubleFieldRow extends StatelessWidget {
  const DoubleFieldRow({super.key, required this.child1, required this.child2});

  final Widget child1;
  final Widget child2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.4,
          child: child1,
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.4,
          child: child2,
        ),
      ],
    );
  }
}
