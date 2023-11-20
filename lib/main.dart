import 'package:app_jms/services/controllers/login_router.dart';
import 'package:app_jms/services/controllers/showcase_manager.dart';
import 'package:app_jms/src/login/log_in_screen.dart';
import 'package:app_jms/src/menu/main_screen.dart';
import 'package:app_jms/src/stock/add_product_screen.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const JmsApp());
}

class JmsApp extends StatelessWidget {
  const JmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ShowcaseManager>(
            create: (_) => ShowcaseManager()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          RouterScreen.id: (_) => const RouterScreen(),
          MainScreen.id: (_) => const MainScreen(),
          LogInScreen.id: (_) => const LogInScreen(),
          AddProductScreen.id: (_) => const AddProductScreen(),
        },
        themeMode: ThemeMode.dark,
        darkTheme: kAppTheme,
      ),
    );
  }
}
