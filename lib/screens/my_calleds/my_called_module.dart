import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:share_it/blocs/called_bloc.dart';
import 'package:share_it/blocs/employee_bloc.dart';

import 'my_called_screen.dart';

class MyCalledModule extends ModuleWidget {
  final EmployeeBloc employeeBloc;

  MyCalledModule(this.employeeBloc);
  @override
  List<Bloc> get blocs => [
    Bloc((i) => CalledBloc())
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => MyCalledScreen(employeeBloc: employeeBloc,);

  static Inject get to => Inject<MyCalledModule>.of();
}