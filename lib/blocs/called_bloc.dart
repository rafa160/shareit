import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/components/custom_toast.dart';
import 'package:share_it/models/called_model.dart';
import 'package:share_it/models/employee_model.dart';

class CalledBloc extends BlocBase {

  StreamController<bool> _streamLoadingController = StreamController<bool>.broadcast();
  Stream get loading => _streamLoadingController.stream;
  Sink get loadingSink => _streamLoadingController.sink;

  Stream<List> myCalledStreamList;
  List<CalledModel> myCalledItems = [];
  StreamSubscription streamSubscription;

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
  
  Stream<List> getMyCalledList({EmployeeBloc employeeBloc}) {
    if(employeeBloc.user.status.index != 1) {
      return myCalledStreamList = _fireStore.collection('called_request')
        .where('company_id', isEqualTo: employeeBloc.user.companyId)
            .snapshots()
            .map((event) =>
                event.docs.map((e) => CalledModel.fromDocument(e)).toList());
    } else {
      return myCalledStreamList = _fireStore.collection('called_request')
          .where('company_id', isEqualTo: employeeBloc.user.companyId).where('employee_email', isEqualTo: employeeBloc.user.email)
          .snapshots()
          .map((event) =>
          event.docs.map((e) => CalledModel.fromDocument(e)).toList());
    }
  }

  List<CalledModel> getCalledModelList({EmployeeBloc employeeBloc}) {
    if (employeeBloc.user.status.index != 1) {
      streamSubscription = _fireStore
          .collection('called_requests')
          .where('company_id', isEqualTo: employeeBloc.user.companyId)
          .snapshots()
          .listen((event) {
        myCalledItems.clear();
        for (final doc in event.docs) {
          myCalledItems.add(CalledModel.fromDocument(doc));
        }
      });
      return myCalledItems;
    } else {
      streamSubscription = _fireStore
          .collection('called_requests')
          .where('company_id', isEqualTo: employeeBloc.user.companyId)
          .where('employee_email', isEqualTo: employeeBloc.user.email)
          .snapshots()
          .listen((event) {
        myCalledItems.clear();
        for (final doc in event.docs) {
          myCalledItems.add(CalledModel.fromDocument(doc));
        }
      });
      return myCalledItems;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _streamLoadingController.close();
    streamSubscription.cancel();
  }
}