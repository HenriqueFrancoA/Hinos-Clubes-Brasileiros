import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'color_schemes.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.white,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
    foregroundColor: Colors.white,
  ),
  dialogBackgroundColor: Colors.white,
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.poppins(
      color: Colors.black,
      decoration: TextDecoration.none,
      fontSize: 16,
    ),
    bodyMedium: GoogleFonts.poppins(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none,
      fontSize: 14,
    ),
    bodySmall: GoogleFonts.poppins(
      color: Colors.black,
      decoration: TextDecoration.none,
      fontSize: 12,
    ),
    titleLarge: GoogleFonts.poppins(
      color: Colors.black,
      decoration: TextDecoration.none,
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.poppins(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 16,
    ),
    labelMedium: GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 14,
    ),
    labelSmall: GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 12,
    ),
    displayLarge: GoogleFonts.poppins(
      color: Colors.red,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: GoogleFonts.poppins(
      color: Colors.red,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: GoogleFonts.poppins(
      color: Colors.red,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
);
