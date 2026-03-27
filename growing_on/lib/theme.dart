import 'package:flutter/material.dart';


Color deepGreen = Color(0xFF849E33);
Color lightGreen = Color(0xFFB3D744);
Color darkGreen = Color(0xFF6B802A);
Color navSeclectedColor = Color(0xFFDCD975);
Color scaffoldBgColor = Color(0xFFFFF8D2);
Color inventoryBgColor = Color(0xFFC29B65);
Color inventorySlotColor = Color(0xFFEFD2AF);
Color shopDescriptionColor = Color(0xFFFFE3C0);
Color rarityColor = Color(0xFFC67AF5);
Color byuyItemColor = Color(0xFF5FC254);

// This blends your background with White by 25%
Color inventoryOutlineColor = Color.lerp(scaffoldBgColor, Colors.black, 0.25)!;
ThemeData themeData = ThemeData(
  colorScheme: .fromSeed(seedColor: deepGreen),

  scaffoldBackgroundColor: scaffoldBgColor,

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: deepGreen,
    elevation: 0,
    unselectedItemColor: deepGreen,
    selectedItemColor: navSeclectedColor,
  ),
);