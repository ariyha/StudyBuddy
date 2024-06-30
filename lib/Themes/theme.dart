import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
    scaffoldBackgroundColor: Color.fromARGB(255, 17, 30, 34),
    primaryColor: Color(0x4b986c),
    primaryTextTheme: TextTheme(
      displayLarge: GoogleFonts.urbanist(textStyle: TextStyle(fontSize: 52)),
      displayMedium: GoogleFonts.urbanist(textStyle: TextStyle(fontSize: 44)),
      displaySmall: GoogleFonts.urbanist(
          textStyle: TextStyle(fontSize: 36, fontWeight: FontWeight.w600)),
      headlineLarge: GoogleFonts.urbanist(textStyle: TextStyle(fontSize: 36)),
      headlineMedium: GoogleFonts.urbanist(
          textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
      headlineSmall: GoogleFonts.urbanist(textStyle: TextStyle(fontSize: 24)),
      titleLarge: GoogleFonts.urbanist(
          textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
      titleMedium: GoogleFonts.plusJakartaSans(
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      titleSmall: GoogleFonts.plusJakartaSans(
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      labelLarge: GoogleFonts.plusJakartaSans(
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      labelMedium: GoogleFonts.plusJakartaSans(
          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      labelSmall: GoogleFonts.plusJakartaSans(
          textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      bodyLarge: GoogleFonts.plusJakartaSans(
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      bodyMedium: GoogleFonts.plusJakartaSans(
          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      bodySmall: GoogleFonts.plusJakartaSans(
          textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
    ));
