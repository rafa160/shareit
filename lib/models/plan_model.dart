import 'package:cloud_firestore/cloud_firestore.dart';


enum PlanStatus {
  small,
  standard,
  superPlan,
}

class PlanModel {
  String id;
  String name;
  int index;
  String value;
  String employees;
  PlanStatus status;

  PlanModel({this.id, this.name, this.index, this.status, this.value, this.employees});

  PlanModel.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    name = snapshot.get('name');
    index = snapshot.get('index');
    value = snapshot.get('value');
    employees = snapshot.get('employees');
    status = PlanStatus.values[snapshot.get('index')];
  }

  PlanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    index = json['index'];
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'index': index,
  };
}
