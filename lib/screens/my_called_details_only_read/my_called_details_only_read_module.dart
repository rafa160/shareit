import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:share_it/blocs/category_bloc.dart';
import 'package:share_it/models/called_model.dart';
import 'package:share_it/screens/my_called_details_only_read/my_called_details_only_read_screen.dart';

class MyCalledDetailsOnlyReadModule extends ModuleWidget {

  final CalledModel calledModel;

  MyCalledDetailsOnlyReadModule(this.calledModel);

  @override
  List<Bloc> get blocs => [
    Bloc((i) => CategoryBloc())
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => MyCalledDetailsOnlyReadScreen(calledModel: calledModel,);

  static Inject get to => Inject<MyCalledDetailsOnlyReadModule>.of();
}