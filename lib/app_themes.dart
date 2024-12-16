import 'package:flutter/material.dart';

class AppThemes {
  // static final lightTheme = ThemeData(
  //   canvasColor: AppColors.lightGreen,
  //   cardColor: AppColors.darkGreen,
  //   primaryColor: AppColors.lightGreen,
  //   brightness: Brightness.light,
  // );

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.lightGreen),
    useMaterial3: true,
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.darkGreen),
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.darkGreen,
  );

  // static final darkTheme = ThemeData(
  //   primaryColor: AppColors.darkGreen,
  //   brightness: Brightness.dark,
  // );
}

class AppColors {

  static final black = Colors.black;
  static final white = Colors.white;
  static final darkGreen = Color.fromARGB(255, 40, 54, 24);
  static final lightGreen = Color.fromARGB(255, 96, 108, 56);
  static final blue = Color.fromARGB(255, 68, 137, 255);
  static final lightBlue = Color.fromARGB(255, 0, 180, 216);

}
