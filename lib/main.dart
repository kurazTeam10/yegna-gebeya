import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yegna_gebeya/app.dart';
import 'package:yegna_gebeya/core/locator.dart';
import 'package:yegna_gebeya/features/buyer/product/presentation/pages/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(const App());
}

