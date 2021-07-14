
import 'package:cloud_firestore/cloud_firestore.dart';

enum EmployeeStatus {
  manager,
  employee,
  support
}

class EmployeeModel {

  String id;
  String name;
  String email;
  bool available;
  bool finishTour;
  String companyId;
  EmployeeStatus status;

  EmployeeModel({this.id, this.name, this.email, this.available, this.finishTour,
      this.companyId, this.status});

  EmployeeModel.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    email = snapshot.get('email');
    name = snapshot.get('name');
    available = snapshot.get('available');
    finishTour = snapshot.get('finish_tour');
    status = EmployeeStatus.values[snapshot.get('role') as int];
    companyId = snapshot.get('company_id');
  }

  String get statusText => getStatusText(status);

  static String getStatusText(EmployeeStatus status) {
    switch (status) {
      case EmployeeStatus.manager:
        return 'Gerencia';
      case EmployeeStatus.employee:
        return 'Funcionario';
      case EmployeeStatus.support:
        return 'Suporte';
      default:
        return '';
    }
  }

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? null;
    name = json['name'];
    email = json['email'];
    available = json['available'];
    finishTour = json['finish_tour'];
    status = EmployeeStatus.values[json['status'] as int];
    companyId = json['company_id'];
  }

  @override
  String toString() {
    return 'EmployeeModel{id: $id, name: $name, email: $email, available: $available, finishTour: $finishTour, companyId: $companyId, status: $status}';
  }
}