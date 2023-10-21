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
