import 'package:app_jms/controllers/showcase_manager.dart';
import 'package:app_jms/views/add_product_screen.dart';
import 'package:flutter/material.dart';
import 'views/main_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ShowcaseManager>(create: (_) => ShowcaseManager())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/' : (_) => const MainScreen(),
          '/add' : (_) => const AddProductScreen(),
        },
      ),
    );
  }
}



