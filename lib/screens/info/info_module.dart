import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:share_it/blocs/called_bloc.dart';
import 'package:share_it/blocs/category_bloc.dart';
import 'package:share_it/screens/info/bloc/info_bloc.dart';

import 'info_screen.dart';

class InfoModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => CategoryBloc()),
    Bloc((i) => CalledBloc()),
    Bloc((i) => InfoBloc()),
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => InfoScreen();

  static Inject get to => Inject<InfoModule>.of();
}