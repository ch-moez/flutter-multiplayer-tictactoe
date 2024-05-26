import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.blue,
    hintColor: Colors.blueAccent,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 5),
  );

  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    hintColor: Colors.blueAccent,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 5),
  );
}
