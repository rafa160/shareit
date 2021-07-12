import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_it/models/category_model.dart';

class CalledModel {

  String id;
  String subject;
  String employeeName;
  String employeeEmail;
  String categoryId;
  String comment;
  int day;
  int month;
  int year;
  bool status;
  CategoryModel categoryModel;
  DateTime calledCreatedTime;
  DateTime calledFinishedTime;
  String companyId;

  CalledModel({
      this.id,
      this.subject,
      this.employeeName,
      this.employeeEmail,
      this.categoryModel,
      this.calledCreatedTime,
      this.calledFinishedTime,
      this.comment,
      this.companyId, this.categoryId,this.day, this.month, this.year, this.status});

  CalledModel.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    subject = snapshot.get('subject');
    employeeName = snapshot.get('employee_name');
    employeeEmail = snapshot.get('employee_email');
    calledCreatedTime = snapshot.get('called_created') != null
        ? DateTime.fromMillisecondsSinceEpoch(
        snapshot.get('called_created').millisecondsSinceEpoch)
        : null;
    calledFinishedTime = snapshot.get('called_finished') != null
        ? DateTime.fromMillisecondsSinceEpoch(
        snapshot.get('called_finished').millisecondsSinceEpoch)
        : null;
    companyId = snapshot.get('company_id');
    categoryId = snapshot.get('category_id');
    day = snapshot.get('day');
    month = snapshot.get('month');
    year = snapshot.get('year');
    status = snapshot.get('status');
    comment = snapshot.get('comment');
  }

  CalledModel.fromMapping(Map<String, dynamic> map) {
    subject = map['subject'];
    employeeName = map['employee_name'];
    employeeEmail = map['employee_email'];
    companyId = map['company_id'];
    categoryId = map['category_id'];
    status = map['status'];
    comment = map['comment'];
  }

  Map<String, dynamic> toJson() => {
    'subject': subject,
    'employee_name': employeeName,
    'employee_email': employeeEmail,
    'company_id': companyId,
    'category_id': categoryId,
    'called_created': calledCreatedTime,
    'day': day,
    'month': month,
    'year': year,
    'called_finished': calledFinishedTime,
    'status': status,
    'comment': comment
  };
}