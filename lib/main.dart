import 'package:app_jms/controllers/showcase_manager.dart';
import 'package:app_jms/controllers/user_provider.dart';
import 'package:app_jms/views/add_product_screen.dart';
import 'package:app_jms/views/log_in_screen.dart';
import 'package:app_jms/views/sales_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'controllers/login_router.dart';
import 'views/stock_screen.dart';
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
        ChangeNotifierProvider<ShowcaseManager>(
            create: (_) => ShowcaseManager()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            // backgroundColor: const Color(0xff131313),
            titleTextStyle: kBrandTextStyle(
              25,
              color: Colors.amber.shade200,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.amber.shade200,
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.black87,
            foregroundColor: Colors.amber.shade100,
          ),
          colorScheme: kColorScheme,
        ),
        debugShowCheckedModeBanner: false,
        home: const RouterScreen(),
      ),
    );
  }
}
