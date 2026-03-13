import 'package:flutter/material.dart';

import 'theme.dart';
import '../screens/main_screen.dart';

class GrowYourHabitsApp extends StatelessWidget {
  const GrowYourHabitsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grow your Habits',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MainScreen(),
    );
  }
}
