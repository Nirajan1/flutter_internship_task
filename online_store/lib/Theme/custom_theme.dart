import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  primaryColor: const Color(0XFFCF7650),
  scaffoldBackgroundColor: Colors.grey.shade200,
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: Color(0XFFCF7650),
    ),
    actionsIconTheme: IconThemeData(
      color: Color(0XFFCF7650),
    ),
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: TextStyle(
      fontSize: 12.0,
    ),
    titleMedium: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w500,
    ),
  ),
);
