import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_it/components/custom_toast.dart';
import 'package:share_it/helpers/firebase_erros.dart';
import 'package:share_it/models/employee_model.dart';
import 'package:share_it/screens/main/main_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeBloc extends BlocBase {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth;

  UserCredential userCredential;
  EmployeeModel user;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _user$ = BehaviorSubject<EmployeeModel>.seeded(null);

  final _userModel = BehaviorSubject<EmployeeModel>();
  Stream<EmployeeModel> get userModel => _userModel.stream;
  Sink<EmployeeModel> get sinkUserModel => _userModel.sink;

  Sink<EmployeeModel> get userIn => _user$.sink;

  StreamController<bool> _streamController = StreamController<bool>.broadcast();
  Stream get loginStream => _streamController.stream;
  Sink get loginSink => _streamController.sink;



  Stream<EmployeeModel> get userOut => _user$.stream
      .asyncMap((v) async {
        if (v == null) {
          return await get<EmployeeModel>('users',
              construct: (v) => EmployeeModel.fromJson(v));
        } else {
          return v;
        }
      })
      .share()
      .cast<EmployeeModel>();

  Future get<S>(String key, {S Function(Map) construct}) async {
    try {
      SharedPreferences share = await _prefs;
      String value = share.getString(key);
      Map<String, dynamic> json = jsonDecode(value);
      if (construct == null) {
        return json;
      } else {
        return construct(json);
      }
    } catch (e) {
      return null;
    }
  }

  Future<EmployeeModel> loggedUserAsync() async {
    return await get<EmployeeModel>("users",
        construct: (v) => EmployeeModel.fromJson(v));
  }


  Future<DocumentSnapshot> getUser({String userId}) async {
    String id;

    if (userId == null) {
      var loggedUser = await loggedUserAsync();
      if (loggedUser == null) return null;
      id = loggedUser.id;
    } else {
      id = userId;
    }

    DocumentSnapshot documentSnapshot =
    await FirebaseFirestore.instance.collection("users").doc(id).get();

    return documentSnapshot.exists ? documentSnapshot : null;
  }

  Future<bool> _saveUserLocally(Map<String, dynamic> json) async {
    try {
      SharedPreferences share = await _prefs;
      share.setString('users', jsonEncode(json));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserCredential> signIn(
      String email, String password, BuildContext context) async {
    _streamController.add(true);
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      var token = await FirebaseAuth.instance.currentUser.getIdToken();
      user = await getUserModel(id: userCredential.user.uid);
      await _saveUserData();
      await isLogged();
      if(user.finishTour == false) {
        // Get.offAll(() => TourScreen());
      } else {
        Get.offAll(() => MainModule());
      }
      _streamController.add(false);
    } on FirebaseAuthException catch (e) {
      _streamController.add(false);
      var error = getErrorString(e.code);
      if (e.code != null) {
        CustomToast.fail(error);
      } else {
        CustomToast.fail('Error');
      }
    }
    return userCredential;
  }

  Future<EmployeeModel> getUserModel({String id}) async {
    try {
      if(id != null) {
        DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(id).get();
        user = EmployeeModel.fromDocument(documentSnapshot);
        _userModel.sink.add(user);
        print(user.toString());
        return user;
      } else {
        user = null;
        return user;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future _saveUserData() async {

    if (userCredential == null) {
      signOut();
    }

    Map<String, dynamic> userData = {
      "id": user.id,
      "email": user.email,
      "name": user.name,
      "finish_tour":  user.finishTour,
      "available":  user.available,
      "company_id": user.companyId
    };

    DocumentSnapshot userModel = await getUser(userId: userCredential.user.uid);
    if (userModel == null) {
      await _fireStore
          .collection('users')
          .doc(userCredential.user.uid)
          .set(userData);
    }
    await _saveUserLocally(userData);
    user = EmployeeModel.fromJson(userData);
    userIn.add(EmployeeModel.fromJson(userData));
  }

  void _deleteUserLocally() async {
    var preference = await _prefs;
    preference.clear();
  }

  Future signOut() async {
    await _auth.signOut();
    firebaseAuth = null;
    userIn.add(null);
    _streamController.add(null);
    _deleteUserLocally();
  }

  Future<bool> isLogged() async {
    var preference = await _prefs;
    return preference.get('users') != null;
  }

  Future<void> updateEmployee({EmployeeBloc employeeBloc, EmployeeModel employeeModel}) async {
    _streamController.add(true);
    user = await loggedUserAsync();
    Map<String, dynamic> userData = {
      "name": employeeModel.name
    };
    _fireStore
        .collection('users')
        .doc(user.id).update(userData);
    CustomToast.success('Úsuario terá dados atualizados após proxima recarga.');
    print(employeeModel.toString());
    _streamController.add(false);
  }

  @override
  void dispose() {
    _user$.close();
    _userModel.close();
    super.dispose();
  }
}