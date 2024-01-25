import 'package:flutter/material.dart';

import '../colors/stock_elements.dart';

ButtonStyle kDefaultElevatedButtonStyle({Color? foregroundColor}) {
  return ButtonStyle(
    shape: MaterialStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    backgroundColor: MaterialStatePropertyAll<Color>(
      kProductDetailsButtonColor,
    ),
    foregroundColor:
        MaterialStatePropertyAll<Color>(foregroundColor ?? Colors.black87),
    textStyle: const MaterialStatePropertyAll<TextStyle>(
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    elevation: MaterialStateProperty.resolveWith<double>((states) {
      if (states.contains(MaterialState.pressed)) {
        return 1;
      } else if (states.contains(MaterialState.hovered)) {
        return 5;
      } else {
        return 3;
      }
    }),
  );
}
