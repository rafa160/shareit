import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_it/models/category_model.dart';

class CategoryBloc extends BlocBase {

  final _firebaseInstance = FirebaseFirestore.instance;

  List<CategoryModel> categories = [];

  CategoryBloc() {
    getCategories();
  }

  Future<List<CategoryModel>> getCategories() async {
    final QuerySnapshot snapshot = await _firebaseInstance.collection('categories').get();
    categories = snapshot.docs.map((e) => CategoryModel.fromDocument(e)).toList();
    print(categories.toString());
    return categories;
  }

}