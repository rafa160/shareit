import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_it/components/app_theme.dart';
import 'package:share_it/screens/login/login_module.dart';
import 'package:share_it/screens/splash/splash_module.dart';
import 'package:share_it/themes/dark.dart';
import 'package:share_it/themes/light.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppTheme(
        defaultBrightness: Brightness.dark,
        themeDataWithBrightnessBuilder: (brightness) =>
        brightness == Brightness.light
            ? ThemeLight.themeLight
            : ThemeDark.themeDark,
        themedBuilder: (context, theme) {
          return GetMaterialApp(
            theme: theme,
            debugShowCheckedModeBanner: false,
            home: SplashModule(),
          );
        });
  }
}
