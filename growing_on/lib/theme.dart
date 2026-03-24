import 'package:flutter/material.dart';


Color deepGreen = Color(0xFF849E33);
Color lightGreen = Color(0xFFB3D744);
Color navSeclectedColor = Color(0xFFDCD975);
Color scaffoldBgCollor = Color(0xFFFFF8D2);

ThemeData themeData = ThemeData(
  colorScheme: .fromSeed(seedColor: deepGreen),

  scaffoldBackgroundColor: scaffoldBgCollor,

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: deepGreen,
    elevation: 0,
    unselectedItemColor: deepGreen,
    selectedItemColor: navSeclectedColor,
  ),
);