import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yegna_gebeya/app.dart';
import 'package:yegna_gebeya/core/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(const App());
}
