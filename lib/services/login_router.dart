import 'package:app_jms/src/shared/components/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class RouterScreen extends StatefulWidget {
  const RouterScreen({super.key});

  static const String id = '/';

  @override
  State<RouterScreen> createState() => _RouterScreenState();
}

class _RouterScreenState extends State<RouterScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      late String route;
      if (FirebaseAuth.instance.currentUser != null) {
        route = kIsWeb ? '/menu' : '/app/menu';
        Navigator.pushNamed(context, route);
      } else {
        route = kIsWeb ? '/login' : '/app/login';
        Navigator.pushNamed(context, route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularLoading()),
    );
  }
}
