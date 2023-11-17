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
  primary: Colors.amber.shade200,
  onPrimary: Colors.white,
  secondary: Colors.black,
  onSecondary: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  background: const Color(0xFFD9D9D9),
  onBackground: Colors.white,
  surface: Colors.black,
  onSurface: Colors.amber.shade200,
);
