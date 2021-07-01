import 'package:flutter/material.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/employee_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var employeeBloc = AppModule.to.getBloc<EmployeeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
