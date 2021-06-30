
import 'package:flutter/material.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/helpers/preferences_manager.dart';

typedef ThemedBuilder = Widget Function(BuildContext context, ThemeData data);

typedef ThemeDataWithBrightnessBuilder = ThemeData Function(
    Brightness brightness);

class AppTheme extends StatefulWidget {
  const AppTheme(
      {Key key, this.data, this.themedBuilder, this.defaultBrightness})
      : super(key: key);

  final ThemedBuilder themedBuilder;
  final ThemeDataWithBrightnessBuilder data;
  final Brightness defaultBrightness;

  @override
  _AppThemeState createState() => _AppThemeState();

  static _AppThemeState of(BuildContext context) {
    return context.findAncestorStateOfType<_AppThemeState>();
  }
}

class _AppThemeState extends State<AppTheme> {
  ThemeData _data;
  Brightness _brightness;

  ThemeData get data => _data;

  Brightness get brightness => _brightness;
  PreferencesManager _preferencesService = AppModule.to.get();

  @override
  void initState() {
    super.initState();
    _brightness = widget.defaultBrightness;
    _data = widget.data(_brightness);

    loadBrightness().then((bool dark) {
      _brightness = dark ? Brightness.dark : Brightness.light;
      _data = widget.data(_brightness);
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<bool> loadBrightness() async {
    return await _preferencesService
            .getBool(PreferencesManager.isThemeDark) ??
        widget.defaultBrightness == Brightness.dark;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _data = widget.data(_brightness);
  }

  @override
  void didUpdateWidget(AppTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    _data = widget.data(_brightness);
  }

  Future<void> setBrightness(Brightness brightness) async {
    setState(() {
      _data = widget.data(brightness);
      _brightness = brightness;
    });

    await _preferencesService.putBool(PreferencesManager.isThemeDark,
        brightness == Brightness.dark ? true : false);
  }

  void setThemeData(ThemeData data) {
    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.themedBuilder(context, _data);
  }
}
