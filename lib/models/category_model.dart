import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {

  String id;
  String name;
  int index;

  CategoryModel({this.id, this.name, this.index});

  @override
  String toString() {
    return 'CategoryModel{id: $id, name: $name, index: $index}';
  }

  CategoryModel.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    name = snapshot.get('name');
    index = snapshot.get('index');
  }

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    index = json['index'];
  }


  CategoryModel.fromMapping(Map<String, dynamic> map) {
    name = map['name'];
    index = map['index'];
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "index": index
  };
}