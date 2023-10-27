import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
  Color color = Colors.green,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      elevation: 3,
    ),
  );
}

void showMaterialBanner(BuildContext context){
  ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(content: Text('a'), actions: []));
}
