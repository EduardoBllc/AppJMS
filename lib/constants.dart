import 'package:app_jms/services/firebase_services.dart';
import 'package:flutter/material.dart';

const Color kModalBackgroundColor = Color(0xff737373);

final OutlineInputBorder kGoldenFieldBorder = OutlineInputBorder(
  borderSide: const BorderSide(color: Colors.amber),
  borderRadius: BorderRadius.circular(5),
);

TextStyle kBrandTextStyle(double fontSize, {Color? color}) {
  return TextStyle(
    fontFamily: 'AbrilFatFace',
    fontSize: fontSize,
    color: color ?? Colors.black,
  );
}

ColorScheme kColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: const Color(0xFFF2CA73),
  onPrimary: const Color(0xFFA68A56),
  secondary: const Color(0xFF594A2E),
  onSecondary: Colors.amber.shade100,
  error: Colors.red.shade200,
  onError: Colors.red,
  background: Colors.grey.shade100,
  onBackground: Colors.white,
  surface: const Color(0xff131313),
  onSurface: const Color(0xFFFFDA8A),
);

AppBar kAppBar(
  BuildContext context, {
  required GlobalKey<ScaffoldState> scaffoldKey,
  required FirebaseServices firebaseServices,
  bool automaticallyImplyLeading = false,
  Color? backgroundColor,
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    elevation: 0,
    automaticallyImplyLeading: automaticallyImplyLeading,
    leading: !automaticallyImplyLeading
        ? GestureDetector(
            onTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                foregroundImage:
                    const AssetImage('assets/images/avatar_default.png'),
                backgroundColor: Colors.grey[600],
              ),
            ),
          )
        : null,
    centerTitle: true,
    title: Text.rich(
      const TextSpan(
        children: [
          TextSpan(
            text: 'JM  ',
            style: TextStyle(fontFamily: 'Montecarlo', fontSize: 30),
          ),
          TextSpan(
            text: 'semijoias',
            style: TextStyle(fontFamily: 'Aboreto', fontSize: 17),
          ),
        ],
      ),
      style: TextStyle(color: Colors.amber.shade200),
    ),
    actions: [
      if (automaticallyImplyLeading)
        GestureDetector(
          onTap: () {
            scaffoldKey.currentState!.openEndDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              foregroundImage:
                  const AssetImage('assets/images/avatar_default.png'),
              backgroundColor: Colors.grey[600],
            ),
          ),
        ),
      IconButton(
        onPressed: () {
          Navigator.pop(context);
          firebaseServices.logOutUser();
          Navigator.pushReplacementNamed(context, '/login');
        },
        icon: const Icon(Icons.logout),
      ),
    ],
  );
}

ThemeData kAppTheme = ThemeData(
  useMaterial3: true,
  colorScheme: kColorScheme,
  appBarTheme: kAppBarTheme,
  navigationBarTheme: kNavigationBarTheme,
  floatingActionButtonTheme: kFABTheme,
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: Colors.grey.shade700,
    ),
    iconColor: Colors.grey.shade700,
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade700,
      ),
    ),
  ),
);

AppBarTheme kAppBarTheme = AppBarTheme(
  backgroundColor: const Color(0xff131313),
  actionsIconTheme: IconThemeData(
    color: Colors.amber.shade200,
  ),
);

NavigationBarThemeData kNavigationBarTheme = NavigationBarThemeData(
  indicatorShape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  indicatorColor: Colors.grey.shade700,
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
);

FloatingActionButtonThemeData kFABTheme = FloatingActionButtonThemeData(
  backgroundColor: Colors.grey.shade800,
  foregroundColor: Colors.amber.shade100,
);

Color kCreamColor = const Color(0Xfff0ede5);
