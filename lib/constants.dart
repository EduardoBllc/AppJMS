import 'package:flutter/material.dart';

const Color kModalBackgroundColor = Color(0xff737373);

final OutlineInputBorder kGoldenFieldBorder = OutlineInputBorder(
  borderSide: const BorderSide(color: Colors.amber),
  borderRadius: BorderRadius.circular(5),
);

TextStyle kBrandTextStyle(double fontSize, {Color? color}) {
  return TextStyle(
    fontFamily: 'AbrilFatFace',
    fontSize: fontSize,
    color: color ?? Colors.black,
  );
}

ColorScheme kColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: const Color(0xFFF2CA73),
  onPrimary: const Color(0xFFA68A56),
  secondary: const Color(0xFF594A2E),
  onSecondary: Colors.amber.shade100,
  error: Colors.red.shade200,
  onError: Colors.red,
  background: Colors.grey.shade100,
  onBackground: Colors.white,
  surface: const Color(0xff131313),
  onSurface: const Color(0xFFFFDA8A),
);
