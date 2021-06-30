import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:share_it/blocs/company_bloc.dart';
import 'package:share_it/blocs/plan_bloc.dart';
import 'package:share_it/screens/request_access/request_access_screen.dart';

class RequestAccessModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => PlanBloc()),
    Bloc((i) => CompanyBloc()),
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => RequestAccessScreen();

  static Inject get to => Inject<RequestAccessModule>.of();
}