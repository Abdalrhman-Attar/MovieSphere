import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF1B1F3B),
    secondary: Color(0xFFF4C430),
    surface: Color(0xFFFFFFFF),
    error: Color(0xFFE74C3C),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF1B1F3B),
    onSurface: Color(0xFF000000),
    onError: Color(0xFFFFFFFF),
  ),
  textTheme: GoogleFonts.poppinsTextTheme(
    const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF000000)),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF000000)),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFF000000)),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFF000000)),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xFF757575)),
      labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Color(0xFF757575)),
    ),
  ),
);
