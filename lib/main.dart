import 'package:app_jms/services/controllers/connection_provider.dart';
import 'package:app_jms/services/controllers/customers_caretaker.dart';
import 'package:app_jms/services/login_router.dart';
import 'package:app_jms/services/controllers/showcase_manager.dart';
import 'package:app_jms/src/app/login/app_log_in_screen.dart';
import 'package:app_jms/src/app/menu/app_menu_screen.dart';
import 'package:app_jms/src/app/stock/add_product_screen.dart';
import 'package:app_jms/src/web/login/web_log_in_page.dart';
import 'package:app_jms/src/web/menu/web_menu_page.dart';
import 'package:app_jms/src/web/pages/customers/customers_page.dart';
import 'package:app_jms/src/web/pages/financial/sales_page.dart';
import 'package:app_jms/src/web/pages/stock/stock_page.dart';
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
        ChangeNotifierProvider<ConnectionProvider>(
            create: (_) => ConnectionProvider()),
        ChangeNotifierProvider<CustomersCaretaker>(
            create: (_) => CustomersCaretaker()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          RouterScreen.id: (_) => const RouterScreen(),
          WebMenuPage.id: (_) => const WebMenuPage(),
          WebLogInPage.id: (_) => const WebLogInPage(),
          AppMenuScreen.id: (_) => const AppMenuScreen(),
          AppLogInScreen.id: (_) => const AppLogInScreen(),
          AddProductScreen.id: (_) => const AddProductScreen(),
          CustomersPage.id: (_) => const CustomersPage(),
          StockPage.id: (_) => const StockPage(),
          SalesPage.id: (_) => const SalesPage(),
        },
        themeMode: ThemeMode.light,
        theme: kAppTheme,
      ),
    );
  }
}
