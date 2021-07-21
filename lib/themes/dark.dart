

import 'package:flutter/material.dart';

class ThemeDark {
  static Color background = Color(0xff434343);
  static Color white = Color(0xffffffff);
  static Color green = Colors.green;
  static Color grey = Colors.grey;
  static Color red1 = Color(0xffC43131);
  static Color black = Colors.black;

  static AppBarTheme createAppBarTheme() {
    return AppBarTheme(
        color: black,
        brightness: Brightness.dark,
        centerTitle: true,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.blue),
        iconTheme: IconThemeData(color: Colors.blue));
  }

  static CardTheme createCardTheme() {
    return CardTheme(
      color: background,
      elevation: 8,
      shadowColor: grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
    );
  }

  /// here u can add the theme colors for almost everything.

  static ThemeData themeDark = new ThemeData(
    brightness: Brightness.dark,
    appBarTheme: createAppBarTheme(),
    backgroundColor: black,
    dividerColor: white,
    errorColor: red1,
    primaryColor: Colors.blue,
    accentColor: Colors.blue,
    primaryColorLight: black,
    primaryColorDark: white,
    scaffoldBackgroundColor: black,
    cardTheme: createCardTheme(),
    iconTheme: IconThemeData(
      color: Colors.blue,
      opacity: 1,
      size: 24,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: black
    ),
  );
}