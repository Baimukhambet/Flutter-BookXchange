import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.yellow,
        primary: Color.fromRGBO(0, 0, 0, 1),
        secondary: Colors.white),
    textTheme: textTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(backgroundColor: Colors.white));

final TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    displayMedium: GoogleFonts.montserrat(
        textStyle: TextStyle(), fontSize: 22, fontWeight: FontWeight.w600),
    titleLarge:
        GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.bold));
