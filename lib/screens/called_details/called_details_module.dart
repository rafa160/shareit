import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:share_it/blocs/called_bloc.dart';
import 'package:share_it/blocs/category_bloc.dart';
import 'package:share_it/models/called_model.dart';
import 'package:share_it/screens/called_details/called_details_screen.dart';

class CalledDetailsModule extends ModuleWidget {

  final CalledModel calledModel;

  CalledDetailsModule({this.calledModel});

  @override
  List<Bloc> get blocs => [
    Bloc((i) => CategoryBloc()),
    Bloc((i) => CalledBloc()),
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => CalledDetailsScreen(calledModel: calledModel,);

  static Inject get to => Inject<CalledDetailsModule>.of();
}