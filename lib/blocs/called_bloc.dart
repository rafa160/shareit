import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/components/custom_toast.dart';
import 'package:share_it/helpers/email_helper.dart';
import 'package:share_it/models/called_model.dart';
import 'package:share_it/models/employee_model.dart';

class CalledBloc extends BlocBase {

  StreamController<bool> _streamLoadingController = StreamController<bool>.broadcast();
  Stream get loading => _streamLoadingController.stream;
  Sink get loadingSink => _streamLoadingController.sink;

  List<CalledModel> myCalledItems = [];
  List<dynamic> supportList = [];
  List<CalledModel> calledByCatId = [];

  EmailHelper _emailHelper = new EmailHelper();

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> createCalledRequest(
      {CalledModel calledModel, EmployeeModel employeeModel, List<EmployeeModel> employeeSupportList}) async {
    try {
      var day = DateTime.now();
      _streamLoadingController.add(true);
      Map<String, dynamic> data = {
        'subject': calledModel.subject,
        'employee_name': calledModel.employeeName,
        'employee_email': calledModel.employeeEmail,
        'company_id': employeeModel.companyId,
        'category_id': calledModel.categoryId,
        'called_created': day,
        'day': day.day,
        'month': day.month,
        'year': day.year,
        'called_finished': calledModel.calledFinishedTime,
        'status': true,
        'comment': calledModel.comment,
        'employee_id': employeeModel.id
      };
      employeeSupportList.forEach((element) {
        supportList.add(element.email);
      });
      await _fireStore.collection('called_requests').add(data);
      await _emailHelper.sendEmailToSupport(supportList, employeeModel, calledModel, day);
      _streamLoadingController.add(false);
      CustomToast.success('Chamado criado com sucesso');
    } catch (e) {
      _streamLoadingController.add(false);
      CustomToast.fail('erro ao tentar criar chamado');
    }
  }

  Future<void> update({CalledModel calledModel, String comment}) async {
    try {
      _streamLoadingController.add(true);
      var day = DateTime.now();
      Map<String, dynamic> data = {
        'called_finished': day,
        'comment': comment,
        'status': false,
      };
      await _fireStore.collection('called_requests').doc(calledModel.id).update(data);
      _streamLoadingController.add(false);
      CustomToast.success('Chamado finalizado com sucesso');
    } catch (e) {
      _streamLoadingController.add(false);
      CustomToast.fail('erro ao fechar o chamado');
    }
  }

  Future<List<CalledModel>> getCalledModelList({EmployeeBloc employeeBloc}) async {
    if (employeeBloc.user.status.index != 1) {
      final QuerySnapshot snapshot = await _fireStore.collection('called_requests')
          .where('company_id', isEqualTo: employeeBloc.user.companyId).get();
      myCalledItems = snapshot.docs.map((e) => CalledModel.fromDocument(e)).toList();
      return myCalledItems;
    } else {
      final QuerySnapshot snapshot = await _fireStore.collection('called_requests')
          .where('employee_id', isEqualTo: employeeBloc.user.id)
          .where('company_id', isEqualTo: employeeBloc.user.companyId).get();
      myCalledItems = snapshot.docs.map((e) => CalledModel.fromDocument(e)).toList();
      return myCalledItems;
    }
  }

  Future<List<CalledModel>> getCalledListByCategoryId(
      {EmployeeModel employeeModel, String id}) async {
    calledByCatId.clear();
    final QuerySnapshot snapshot =
    await _fireStore.collection('called_requests').where('company_id', isEqualTo: employeeModel.companyId).where('category_id', isEqualTo: id).get();
    calledByCatId =
        snapshot.docs.map((e) => CalledModel.fromDocument(e)).toList();
    return calledByCatId;
  }

  @override
  void dispose() {
    super.dispose();
    _streamLoadingController.close();
    // streamSubscription.cancel();
  }
}