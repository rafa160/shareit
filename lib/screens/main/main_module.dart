import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:share_it/screens/main/main_screen.dart';


class MainModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [

  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => MainScreen();

  static Inject get to => Inject<MainModule>.of();
}