

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_it/models/plan_model.dart';

class PlanBloc extends BlocBase {

  final _firebaseInstance = FirebaseFirestore.instance;

  List<PlanModel> planList = [];
  PlanModel _planModel;

  Future<List<PlanModel>> getPlans() async {
    final QuerySnapshot snapshot =
        await _firebaseInstance.collection('plans').orderBy('index').get();
    planList = snapshot.docs.map((e) => PlanModel.fromDocument(e)).toList();
    return planList;
  }

  Future<PlanModel> getPlanById(String id) async {
    final DocumentSnapshot snapshot =
        await _firebaseInstance.collection('plans').doc(id).get();
    _planModel = PlanModel.fromDocument(snapshot);
    return _planModel;
  }
}