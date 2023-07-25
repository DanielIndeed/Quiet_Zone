// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

int? val_age;

Future<void> setAge(int val_age) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setInt('val_age', val_age);
}

Future<void> getAge() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  val_age = pref.getInt('val_age');
}
