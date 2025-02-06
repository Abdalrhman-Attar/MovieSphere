import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF1B1F3B),
    secondary: Color(0xFFF4C430),
    surface: Color(0xFF22273B),
    error: Color(0xFFE74C3C),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF1B1F3B),
    onSurface: Color(0xFFFFFFFF),
    onError: Color(0xFF000000),
  ),
  textTheme: GoogleFonts.poppinsTextTheme(
    const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFFFFFFFF)),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFFB0B0B0)),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFFFFFFFF)),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFFFFFFFF)),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF121212)),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xFFB0B0B0)),
      labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Color(0xFFB0B0B0)),
    ),
  ),
);
