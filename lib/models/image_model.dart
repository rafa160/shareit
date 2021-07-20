import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel {

  String image;

  ImageModel({this.image});

  ImageModel.fromDocument(DocumentSnapshot snapshot) {
    image = snapshot.get('image');
  }
}