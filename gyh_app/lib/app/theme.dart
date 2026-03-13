import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primary = Color(0xFF849E33);
  static const Color primaryLighter = Color(0xFFB3D744);
  static const Color scaffoldBackground = Color(0xFFFFF8D2);
  static const Color navSelectedBg = Color.fromARGB(170, 205, 222, 151);
  static const Color navUnselectedBg = Color.fromARGB(32, 255, 255, 255);
  static const Color navSelectedIcon = Color(0xFFDCD975);
  static const Color navUnselectedIcon = primary;

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
          primary: primary,
          surface: const Color.fromARGB(255, 255, 255, 255),
        ),
        scaffoldBackgroundColor: scaffoldBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: primary,
          selectedItemColor: navSelectedIcon,
          unselectedItemColor: navUnselectedIcon,
          type: BottomNavigationBarType.fixed,
        ),
      );
}
