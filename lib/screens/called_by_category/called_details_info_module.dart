import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:share_it/blocs/called_bloc.dart';
import 'package:share_it/screens/called_by_category/called_details_info_screen.dart';

class CalledByCategoryModule extends ModuleWidget {

  final String categoryId;
  final String category;
  CalledByCategoryModule({this.categoryId, this.category});

  @override
  List<Bloc> get blocs => [
    Bloc((i) => CalledBloc()),
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => CalledByCategoryScreen(categoryId: categoryId, category: category,);

  static Inject get to => Inject<CalledByCategoryModule>.of();
}