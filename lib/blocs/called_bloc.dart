import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_it/components/custom_toast.dart';
import 'package:share_it/models/called_model.dart';
import 'package:share_it/models/employee_model.dart';

class CalledBloc extends BlocBase {

  StreamController<bool> _streamLoadingController = StreamController<bool>.broadcast();
  Stream get loading => _streamLoadingController.stream;
  Sink get loadingSink => _streamLoadingController.sink;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> createCalledRequest(
      {CalledModel calledModel, EmployeeModel employeeModel}) async {
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
        'comment': calledModel.comment
      };
      await _fireStore.collection('called_requests').add(data);
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

  @override
  void dispose() {
    super.dispose();
    _streamLoadingController.close();
  }
}