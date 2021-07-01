import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:share_it/models/employee_model.dart';
import 'package:share_it/screens/profile/edit_profile/edit_profile_screen.dart';


class EditProfileModule extends ModuleWidget {
  final EmployeeModel employeeModel;

  EditProfileModule(this.employeeModel);

  @override
  List<Bloc> get blocs => [
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => EditProfileScreen(employeeModel:employeeModel);

  static Inject get to => Inject<EditProfileModule>.of();
}