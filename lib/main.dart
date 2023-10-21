import 'package:app_jms/controllers/showcase_manager.dart';
import 'package:app_jms/controllers/user_provider.dart';
import 'package:app_jms/views/add_product_screen.dart';
import 'package:app_jms/views/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'views/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ShowcaseManager>(create: (_) => ShowcaseManager()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          MainScreen.id: (_) => const MainScreen(),
          AddProductScreen.id: (_) => const AddProductScreen(),
          LogInScreen.id: (_) => const LogInScreen(),
        },
      ),
    );
  }
}
