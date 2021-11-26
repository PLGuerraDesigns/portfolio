import 'package:flutter/material.dart';

/// The AppTheme class contains predefined themes that are
/// used throughout the application.
class AppTheme {
  AppTheme._();

  /// Dark mode theme (black background, light text).
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900], elevation: 2, centerTitle: false),
    fontFamily: "SFPro",
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 54, fontWeight: FontWeight.w300, color: Colors.white70),
      headline2: TextStyle(
          fontSize: 48, fontWeight: FontWeight.w300, color: Colors.white70),
      headline3: TextStyle(
          fontSize: 34, fontWeight: FontWeight.w300, color: Colors.white70),
      headline4: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white70),
      headline5: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white70),
      headline6: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white70),
      subtitle1: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white70),
      subtitle2: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white70),
      bodyText1: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white70),
      bodyText2: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white70),
      button: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white54),
      caption: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white70),
      overline: TextStyle(
          fontSize: 10, fontWeight: FontWeight.w400, color: Colors.white70),
    ),
  );
}
