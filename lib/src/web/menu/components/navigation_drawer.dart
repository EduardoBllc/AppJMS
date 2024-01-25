import 'package:flutter/material.dart';

class MenuNavigationDrawer extends StatelessWidget {
  const MenuNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 50, maxWidth: 400),
      color: Colors.white,
    );
  }
}
