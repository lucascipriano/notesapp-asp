import 'package:flutter/material.dart';

const primaryColor = Colors.deepPurple;
const secondColor = Colors.purple;

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
  ),
  textTheme: const TextTheme(
    titleSmall: TextStyle(
      color: Colors.black87,
      fontSize: 16,
    ),
    titleMedium: TextStyle(
      color: Colors.black87,
      fontSize: 20,
    ),
    titleLarge: TextStyle(
      color: Colors.black87,
      fontSize: 24,
    ),
  ),
);
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: secondColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: secondColor,
  ),
  textTheme: const TextTheme(
    titleSmall: TextStyle(
      color: Colors.white70,
      fontSize: 16,
    ),
    titleMedium: TextStyle(
      color: Colors.white70,
      fontSize: 20,
    ),
    titleLarge: TextStyle(
      color: Colors.white70,
      fontSize: 24,
    ),
  ),
);
