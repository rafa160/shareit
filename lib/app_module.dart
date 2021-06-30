import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:share_it/app_widget.dart';
import 'package:share_it/helpers/preferences_manager.dart';

import 'blocs/employee_bloc.dart';


class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
    Bloc((i) => EmployeeBloc())
  ];

  @override
  List<Dependency> get dependencies => [
    Dependency((i) => PreferencesManager()),
  ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}