import 'package:flutter/material.dart';

final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.yellow, primary: Color.fromRGBO(0, 0, 0, 1)),
    textTheme: textTheme,
    scaffoldBackgroundColor: Colors.grey[300],
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey[300]));

final TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600));
