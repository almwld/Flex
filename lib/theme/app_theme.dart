import 'package:flutter/material.dart';

class AppTheme {
  // الألوان الذهبية
  static const Color goldColor = Color(0xFFD4AF37);
  static const Color goldPrimary = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFF4E4BC);
  static const Color goldDark = Color(0xFFB8860B);
  static const Color goldAccent = Color(0xFFFFD700);
  
  // ألوان الخلفية
  static const Color black = Color(0xFF0A0A0A);
  static const Color darkGrey = Color(0xFF1A1A1A);
  static const Color grey = Color(0xFF2A2A2A);
  static const Color lightGrey = Color(0xFF888888);
  static const Color white = Colors.white;
  
  // ألوان البطاقات
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color lightCard = Color(0xFF2C2C2C);
  
  // ألوان الحالات
  static const Color error = Color(0xFFFF1744);
  static const Color success = Color(0xFF00C853);
  static const Color warning = Color(0xFFFF9100);
  static const Color info = Color(0xFF00B0FF);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: black,
      primaryColor: goldColor,
      colorScheme: const ColorScheme.dark(
        primary: goldColor,
        secondary: goldDark,
        surface: darkGrey,
        error: error,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: goldColor),
        titleTextStyle: TextStyle(
          color: goldColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkGrey,
        selectedItemColor: goldColor,
        unselectedItemColor: lightGrey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: goldColor,
          foregroundColor: Colors.black,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
