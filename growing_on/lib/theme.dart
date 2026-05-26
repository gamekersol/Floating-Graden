import 'package:flutter/material.dart';
import 'models/item.dart';


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

const Map<Rarity, Color> RARITY_COLOR = {
  Rarity.theonlyone : Color.fromARGB(255, 255, 255, 255),
  Rarity.forgoten : Color.fromARGB(255, 30, 30, 30),
  Rarity.mythical : Color.fromARGB(255, 156, 60, 82),
  Rarity.vanished : Color.fromARGB(255, 104, 162, 65),
  Rarity.divided : Color.fromARGB(255, 34, 185, 104),
  Rarity.veryrare : Color.fromARGB(255, 135, 71, 152),
  Rarity.rare : Color.fromARGB(255, 52, 89, 145),
  Rarity.uncommon : Color.fromARGB(255, 104, 148, 156),
  Rarity.common : Color.fromARGB(255, 119, 119, 119),
};
TextStyle basicTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w900,
  color: Colors.white,
  shadows: [
    Shadow(
    color: Colors.black.withAlpha(70),
    offset: Offset.fromDirection(1)*2,
    )
  ]
);

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

  textTheme: TextTheme(
      bodyMedium: basicTextStyle
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(basicTextStyle),
    )
  )
);