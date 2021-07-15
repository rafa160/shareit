import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_it/models/plan_model.dart';

class CompanyModel {

  String id;
  String personInChargeName;
  String name;
  String document;
  String email;
  String phone;
  String planId;
  PlanModel planModel;
  bool available;

  CompanyModel({this.personInChargeName, this.name, this.document, this.email,
      this.phone, this.planModel, this.id, this.available, this.planId});

  CompanyModel.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    name = snapshot.get('name');
    personInChargeName = snapshot.get('person_name');
    document = snapshot.get('document');
    email = snapshot.get('email');
    phone = snapshot.get('phone');
    planModel = PlanModel.fromJson(snapshot.get('plan'));
    available = snapshot.get('available');
  }

  CompanyModel.fromMapping(Map<String, dynamic> map) {
    name = map['name'];
    personInChargeName = map['person_name'];
    document = map['document'];
    email = map['email'];
    phone = map['phone'];
    planId = map['plan'];
  }

  Map<String, dynamic> toJson() => {
    "id": document,
    "name": name,
    "person_name": personInChargeName,
    "document": document,
    "email": email,
    "phone": phone,
    "plan": planModel.toMap(),
    "available": available,
  };

  @override
  String toString() {
    return 'CompanyModel{id: $id, personInChargeName: $personInChargeName, name: $name, document: $document, email: $email, phone: $phone, planId: $planId, planModel: $planModel, available: $available}';
  }
}