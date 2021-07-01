import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_it/blocs/plan_bloc.dart';
import 'package:share_it/components/custom_toast.dart';
import 'package:share_it/helpers/email_helper.dart';
import 'package:share_it/models/company_model.dart';
import 'package:share_it/models/plan_model.dart';

class CompanyBloc extends BlocBase {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  PlanBloc planBloc = new PlanBloc();
  EmailHelper _emailHelper = new EmailHelper();
  StreamController<bool> _streamLoadingController = StreamController<bool>.broadcast();
  Stream get loading => _streamLoadingController.stream;
  Sink get loadingSink => _streamLoadingController.sink;

  Future<void> createCompanyPreOrder(CompanyModel companyModel) async {
    _streamLoadingController.add(true);
    if(companyModel != null) {
      PlanModel _planModel = await planBloc.getPlanById(companyModel.planId);
      companyModel.planModel = PlanModel.fromJson(_planModel.toMap());
      companyModel.available = true;
      await _emailHelper.sendMessageToCompanyPlanZero(companyModel.planModel.name, companyModel.email, _planModel.employees, companyModel.name);
      await _fireStore.collection('companies').add(companyModel.toJson());
      _streamLoadingController.add(false);
      CustomToast.success('Solicitação enviada com sucesso');
    } else {
      _streamLoadingController.add(false);
      CustomToast.fail('Sua Solicitação já está em analise, aguarde...');
    }

  }

  Future<CompanyModel> getCompanyById(String id) async {
    try {
      final DocumentSnapshot documentSnapshot =
      await _fireStore.collection('companies').doc(id).get();
      CompanyModel companyModel = CompanyModel.fromDocument(documentSnapshot);
      return companyModel;
    } catch (e){
      CustomToast.fail('error');
    }
  }
}


