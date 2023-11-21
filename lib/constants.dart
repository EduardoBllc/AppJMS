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

ThemeData kAppTheme = ThemeData(
  useMaterial3: true,
  colorScheme: kColorScheme,
  appBarTheme: kAppBarTheme,
  navigationBarTheme: kNavigationBarTheme,
  floatingActionButtonTheme: kFABTheme,
  inputDecorationTheme: kInputDecorationTheme,
  navigationRailTheme: kNavigationRailThemeData,
  bottomAppBarTheme: kBottomAppBarTheme,
);

InputDecorationTheme kInputDecorationTheme = InputDecorationTheme(
  labelStyle: TextStyle(
    color: Colors.grey.shade700,
  ),
  iconColor: Colors.grey.shade700,
  border: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.shade700,
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

BottomAppBarTheme kBottomAppBarTheme = const BottomAppBarTheme(
  color: Color(0Xfff0eee9),
  shape: CircularNotchedRectangle(),
);

NavigationRailThemeData kNavigationRailThemeData = NavigationRailThemeData(
  useIndicator: false,
  backgroundColor: const Color(0Xfff0eee9),
  labelType: NavigationRailLabelType.all,
  unselectedLabelTextStyle: const TextStyle(
    color: Colors.black,
  ),
  unselectedIconTheme: IconThemeData(
    color: kColorScheme.onPrimary,
    size: 30,
  ),
  selectedLabelTextStyle: const TextStyle(
    color: Colors.black,
  ),
  selectedIconTheme: IconThemeData(
    color: kColorScheme.primary,
    size: 80,
  ),
);

FloatingActionButtonThemeData kFABTheme = FloatingActionButtonThemeData(
  backgroundColor: Colors.grey.shade800,
  foregroundColor: Colors.amber.shade100,
);

Color kCreamColor = const Color(0Xfff0ede5);
