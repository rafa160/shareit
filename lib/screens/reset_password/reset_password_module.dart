import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/screens/reset_password/reset_password_screen.dart';


class ResetPasswordModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
    Bloc((i) => EmployeeBloc()),
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ResetPasswordScreen();

  static Inject get to => Inject<ResetPasswordModule>.of();
}