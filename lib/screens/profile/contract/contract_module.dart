import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:share_it/blocs/company_bloc.dart';
import 'package:share_it/screens/profile/contract/contract_screen.dart';


class ContractModule extends ModuleWidget {

  final String companyId;

  ContractModule({this.companyId});

  @override
  List<Bloc> get blocs => [
    Bloc((i) => CompanyBloc()),
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => ContractScreen(companyId: companyId);

  static Inject get to => Inject<ContractModule>.of();
}