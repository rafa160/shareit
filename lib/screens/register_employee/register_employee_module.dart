import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:share_it/blocs/company_bloc.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/blocs/plan_bloc.dart';
import 'package:share_it/models/company_model.dart';
import 'package:share_it/screens/register_employee/register_employee_screen.dart';

class RegisterEmployeeModule extends ModuleWidget {

  final CompanyModel companyModel;
  final String id;

  RegisterEmployeeModule(this.companyModel, this.id);

  @override
  List<Bloc> get blocs => [
    Bloc((i) => PlanBloc()),
    Bloc((i) => CompanyBloc()),
    Bloc((i) => EmployeeBloc()),
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => RegisterEmployeeScreen(companyModel: companyModel, id: id,);

  static Inject get to => Inject<RegisterEmployeeModule>.of();
}