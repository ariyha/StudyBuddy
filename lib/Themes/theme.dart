import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 17, 30, 34),
  primaryColor: const Color.fromARGB(255, 75, 152, 108),
  colorScheme: const ColorScheme(
    primary: Color.fromARGB(255, 75, 152, 108),
    secondary: Color.fromARGB(255, 146, 129, 99),
    tertiary: Color.fromARGB(255, 109, 96, 74),
    surface: Color.fromARGB(255, 23, 40, 46),
    background: Color.fromARGB(255, 11, 25, 30),
    error: Color.fromARGB(255, 196, 69, 77),
    onPrimary: Color.fromARGB(255, 255, 255, 255),
    onSecondary: Color.fromARGB(255, 101, 133, 147),
    onSurface: Color.fromARGB(255, 255, 255, 255),
    onBackground: Color.fromARGB(255, 255, 255, 255),
    onError: Color.fromARGB(255, 255, 255, 255),
    brightness: Brightness.dark,
  ),
  primaryTextTheme: TextTheme(
    displayLarge: GoogleFonts.urbanist(textStyle: TextStyle(fontSize: 52)),
    displayMedium: GoogleFonts.urbanist(textStyle: TextStyle(fontSize: 44)),
    displaySmall: GoogleFonts.urbanist(
        textStyle: const TextStyle(fontSize: 36, fontWeight: FontWeight.w600)),
    headlineLarge: GoogleFonts.urbanist(textStyle: TextStyle(fontSize: 36)),
    headlineMedium: GoogleFonts.urbanist(
        textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
    headlineSmall: GoogleFonts.urbanist(textStyle: TextStyle(fontSize: 24)),
    titleLarge: GoogleFonts.urbanist(
        textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
    titleMedium: GoogleFonts.plusJakartaSans(
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    titleSmall: GoogleFonts.plusJakartaSans(
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    labelLarge: GoogleFonts.plusJakartaSans(
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    labelMedium: GoogleFonts.plusJakartaSans(
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    labelSmall: GoogleFonts.plusJakartaSans(
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
    bodyLarge: GoogleFonts.plusJakartaSans(
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    bodyMedium: GoogleFonts.plusJakartaSans(
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    bodySmall: GoogleFonts.plusJakartaSans(
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
  ),
  navigationBarTheme: NavigationBarThemeData(
    height: 65,
    backgroundColor: Color.fromARGB(255, 17, 30, 34),
    indicatorColor: Color.fromARGB(255, 42, 157, 143),
    iconTheme: MaterialStateProperty.all(
      IconThemeData(color: Colors.white),
    ),
    labelTextStyle: MaterialStateProperty.all(
      const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color.fromARGB(255, 17, 30, 34),
    elevation: 0, // Flat app bar
    centerTitle: false, // Align title to the left
    titleTextStyle: GoogleFonts.urbanist(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.w600,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white, // White icons
    ),
    actionsIconTheme: const IconThemeData(
      color: Colors.white, // White action icons
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(16),
      ),
    ),
  ),
);

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Modern AppBar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text('Hello, world!'),
      ),
    );
  }
}
