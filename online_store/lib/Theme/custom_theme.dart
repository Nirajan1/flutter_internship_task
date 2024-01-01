import 'package:flutter/material.dart';
import 'package:online_store/Utils/app_color.dart';

final ThemeData myTheme = ThemeData(
  primaryColor: const Color(0XFFCF7650),
  scaffoldBackgroundColor: Colors.grey.shade200,
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: AppColor.primaryColor,
    ),
    actionsIconTheme: IconThemeData(
      color: AppColor.ionColor,
    ),
    // backgroundColor: AppColor.backgroundColor,
    centerTitle: true,
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
      letterSpacing: 2,
    ),
    headlineSmall: TextStyle(
      color: Colors.black87,
      fontSize: 12.0,
    ),
    titleMedium: TextStyle(
      fontSize: 18.0,
      color: Colors.black87,
      fontWeight: FontWeight.w600,
    ),
    //*used in product details page title
    titleSmall: TextStyle(
      fontSize: 14.0,
      color: Colors.black54,
      fontWeight: FontWeight.w400,
    ),
  ),
);
