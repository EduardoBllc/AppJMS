import 'package:flutter/material.dart';

List<BoxShadow> kDefaultBoxShadow(
    {double dx = 0, double dy = 3, double blurRadius = 3}) {
  return [
    BoxShadow(
      color: const Color(0x3F000000),
      offset: Offset(dx, dy),
      blurRadius: blurRadius,
    ),
  ];
}
