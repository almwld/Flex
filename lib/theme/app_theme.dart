import 'package:flutter/material.dart';

class AppTheme {
  static const Color goldColor = Color(0xFFD4AF37);
  static const Color darkGold = Color(0xFFB8860B);
  static const Color lightGold = Color(0xFFF4E4BC);
  static const Color black = Color(0xFF0A0A0A);
  static const Color darkGrey = Color(0xFF1A1A1A);
  static const Color grey = Color(0xFF2A2A2A);
  static const Color lightGrey = Color(0xFF888888);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color lightCard = Color(0xFF2C2C2C);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: black,
      primaryColor: goldColor,
      colorScheme: const ColorScheme.dark(
        primary: goldColor,
        secondary: darkGold,
        surface: darkGrey,
      ),
      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
