import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../src/login/log_in_screen.dart';
import '../../src/menu/main_screen.dart';

class RouterScreen extends StatelessWidget {
  const RouterScreen({super.key});

  static const String id = '/';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const MainScreen();
        } else {
          return const LogInScreen();
        }
      },
    );
  }
}
