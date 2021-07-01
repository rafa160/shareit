import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:share_it/blocs/version_bloc.dart';
import 'package:share_it/helpers/preferences_manager.dart';
import 'package:share_it/screens/profile/profile_screen.dart';


class ProfileModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
    Bloc((i) => VersionBloc())
  ];

  @override
  List<Dependency> get dependencies => [
    Dependency((i) => PreferencesManager()),
  ];

  @override
  Widget get view =>ProfileScreen();

  static Inject get to => Inject<ProfileModule>.of();
}