import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:share_it/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AppModule());
}


