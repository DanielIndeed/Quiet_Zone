// ignore_for_file: non_constant_identifier_names, duplicate_ignore, use_build_context_synchronously, prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/sound_meter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'age.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getAge();
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    if (val_age != null) {
      return MaterialApp(
        home: Sound_meter(),
      );
    } else {
      return MaterialApp(
        home: Login(),
      );
    }
  }
}

Future<void> getAge() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  val_age = pref.getInt('val_age');
}
