import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {

  String id;
  String name;

  CategoryModel({this.id, this.name});

  @override
  String toString() {
    return 'CategoryModel{id: $id, name: $name}';
  }

  CategoryModel.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    name = snapshot.get('name');
  }

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }


  CategoryModel.fromMapping(Map<String, dynamic> map) {
    name = map['name'];
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}