import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
  Color color = Colors.green,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      elevation: 3,
    ),
  );
}
