import 'package:flutter/material.dart';

class ThemeUtils {
  static ThemeData themeData = ThemeData(
    fontFamily: 'NeusaNextStd',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: Color(0xFF515C6F),
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      button: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    colorScheme:
        ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 251, 98, 64)),
    useMaterial3: true,
  );
}
