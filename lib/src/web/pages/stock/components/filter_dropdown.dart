import 'package:flutter/material.dart';

class FilterDropdown<T> extends StatelessWidget {
  const FilterDropdown({
    super.key,
    required this.icon,
    required this.label,
    required this.items,
    required this.onChanged,
    this.width = 150,
  });

  final Icon icon;
  final String label;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: icon,
          hintText: label,
          border: const UnderlineInputBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(6),
            ),
          ),
        ),
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
