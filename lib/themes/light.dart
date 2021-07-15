
import 'package:flutter/material.dart';

class ThemeLight {
  static Color tableTitleColor = Color(0xff434343);
  static Color background = Color(0xffffffff);
  static Color green = Colors.blue;
  static Color grey = Colors.grey;
  static Color red1 = Color(0xffC43131);

  static AppBarTheme createAppBarTheme() {
    return AppBarTheme(
        color: background,
        brightness: Brightness.dark,
        centerTitle: true,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: green),
        iconTheme: IconThemeData(color: green));
  }

  static CardTheme createCardTheme() {
    return CardTheme(
      color: background,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
    );
  }

  static ThemeData themeLight = new ThemeData(
    brightness: Brightness.light,
    appBarTheme: createAppBarTheme(),
    backgroundColor: background,
    dividerColor: grey,
    errorColor: red1,
    accentColor: green,
    primaryColor: background,
    primaryColorLight: green,
    primaryColorDark: tableTitleColor,
    scaffoldBackgroundColor: background,
    cardTheme: createCardTheme(),
    iconTheme: IconThemeData(
      color: green,
      opacity: 1,
      size: 24,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: background,
    ),
  );
}
