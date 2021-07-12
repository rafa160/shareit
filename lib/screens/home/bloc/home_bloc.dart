import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/models/called_model.dart';
import 'package:share_it/models/employee_model.dart';

class HomeBloc extends BlocBase {

  final _firebaseInstance = FirebaseFirestore.instance;

  final _today$ = BehaviorSubject<DateTime>();
  Stream<DateTime> get todayDateTime$ => _today$.stream;
  Sink<DateTime> get sinkTodayDateTime$ => _today$.sink;

  final _yesterday$ = BehaviorSubject<DateTime>();
  Stream<DateTime> get yesterdayDateTime$ => _yesterday$.stream;
  Sink<DateTime> get sinkYesterdayDateTime$ => _yesterday$.sink;
  var now = DateTime.now();

  Stream<List> todayCalledStreamList;
  Stream<List> yesterdayCalledStreamList;
  Stream<List> monthCalledStreamList;
  StreamSubscription streamSubscription;

  List<CalledModel> todayCalledItems = [];
  List<CalledModel> yesterdayCalledItems = [];
  List<CalledModel> monthCalledList = [];

  HomeBloc() {
    getTodayDateTime();
    getYesterdayDateTime();
  }

  Future<DateTime> getTodayDateTime() async {
    var today = DateTime(now.year, now.month, now.day);
    _today$.sink.add(today);
    print(today.toString());
    return today;
  }

  Future<DateTime> getYesterdayDateTime() async {
    var yesterday = DateTime(now.year, now.month, now.day - 1);
    _yesterday$.sink.add(yesterday);
    print(yesterday.toString());
    return yesterday;
  }

  Stream<List> getCalledItems(EmployeeBloc employeeBloc) {
    return todayCalledStreamList = _firebaseInstance
        .collection('called_requests')
        .where('company_id', isEqualTo: employeeBloc.user.companyId)
        .where('day',  isEqualTo: now.day)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => CalledModel.fromDocument(e)).toList());
  }

  Stream<List> getYesterdayCalledItems(EmployeeBloc employeeBloc) {
    return yesterdayCalledStreamList = _firebaseInstance
        .collection('called_requests')
        .where('company_id', isEqualTo: employeeBloc.user.companyId)
        .where('day',  isEqualTo: now.day - 1)
        .snapshots()
        .map((event) =>
        event.docs.map((e) => CalledModel.fromDocument(e)).toList());
  }

  Stream<List> getMonthCalledList(EmployeeBloc employeeBloc) {
    return monthCalledStreamList = _firebaseInstance
        .collection('called_requests')
        .where('company_id', isEqualTo: employeeBloc.user.companyId)
        .where('month',  isEqualTo: now.month)
        .snapshots()
        .map((event) =>
        event.docs.map((e) => CalledModel.fromDocument(e)).toList());
  }

  List<CalledModel> getListTodayCalledNumber(EmployeeBloc employeeBloc) {
    streamSubscription = _firebaseInstance.collection('called_requests')
        .where('company_id', isEqualTo: employeeBloc.user.companyId)
        .where('day', isEqualTo: now.day).snapshots().listen((event) {
          todayCalledItems.clear();
       for(final doc in event.docs) {
         todayCalledItems.add(CalledModel.fromDocument(doc));
       }
    });
    return todayCalledItems;
  }

  List<CalledModel> getListYesterdayCalledNumber(EmployeeBloc employeeBloc) {
    var yesterday = now.day -1;
    streamSubscription = _firebaseInstance.collection('called_requests')
        .where('company_id', isEqualTo: employeeBloc.user.companyId)
        .where('day', isEqualTo: yesterday).snapshots().listen((event) {
      yesterdayCalledItems.clear();
      for(final doc in event.docs) {
        yesterdayCalledItems.add(CalledModel.fromDocument(doc));
      }
    });
    return yesterdayCalledItems;
  }

  List<CalledModel> getListMonthCalledNumber(EmployeeBloc employeeBloc) {

    streamSubscription = _firebaseInstance.collection('called_requests')
        .where('company_id', isEqualTo: employeeBloc.user.companyId)
        .where('month', isEqualTo: now.month).snapshots().listen((event) {
      monthCalledList.clear();
      for(final doc in event.docs) {
        monthCalledList.add(CalledModel.fromDocument(doc));
      }
    });
    return monthCalledList;
  }

  @override
  void dispose() {
    super.dispose();
    _today$.close();
    streamSubscription.cancel();
    _yesterday$.close();
  }
}