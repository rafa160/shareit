import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:share_it/screens/tour/tour_screen.dart';

class TourModule extends ModuleWidget {


  @override
  List<Bloc> get blocs => [
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => TourScreen();

  static Inject get to => Inject<TourModule>.of();
}