import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:share_it/blocs/called_bloc.dart';
import 'package:share_it/blocs/category_bloc.dart';
import 'package:share_it/models/employee_model.dart';
import 'package:share_it/screens/new_called/new_called_screen.dart';

class NewCalledModule extends ModuleWidget {
  final EmployeeModel employeeModel;

  NewCalledModule(this.employeeModel);

  @override
  List<Bloc> get blocs => [
    Bloc((i) => CategoryBloc()),
    Bloc((i) => CalledBloc())
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => NewCalledScreen(employeeModel: employeeModel,);

  static Inject get to => Inject<NewCalledModule>.of();
}