import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/screens/login/login_screen.dart';


class LoginModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
    Bloc((i) => EmployeeBloc()),
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => LoginScreen();

  static Inject get to => Inject<LoginModule>.of();
}