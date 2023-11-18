import 'package:app_jms/services/controllers/login_router.dart';
import 'package:app_jms/services/controllers/showcase_manager.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
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
    TextStyle blackFont = const TextStyle(color: Colors.black);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ShowcaseManager>(
            create: (_) => ShowcaseManager()),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xff131313),
            titleTextStyle: kBrandTextStyle(
              25,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.amber.shade200,
            ),
          ),
          navigationBarTheme: NavigationBarThemeData(
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            indicatorColor: Colors.black.withOpacity(0.7),
            labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
              (Set<MaterialState> states) {
                return const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                );
              },
            ),
            iconTheme: MaterialStateProperty.resolveWith<IconThemeData>(
              (Set<MaterialState> states) {
                return IconThemeData(
                  color: states.contains(MaterialState.selected)
                      ? kColorScheme.primary
                      : kColorScheme.onPrimary,
                );
              },
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.black87,
            foregroundColor: Colors.amber.shade100,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const RouterScreen(),
      ),
    );
  }
}
