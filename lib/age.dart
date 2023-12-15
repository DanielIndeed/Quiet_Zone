// ignore_for_file: non_constant_identifier_names, duplicate_ignore, use_build_context_synchronously, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_application_1/sound_meter.dart';
import 'package:flutter_application_1/utils/style/text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/Age_shared_preferences/age_input.dart';
import 'utils/Permissions/permissions.dart';
import 'dart:ui' as ui;

void main() => runApp(const MaterialApp(home: Age()));

// ignore: prefer_typing_uninitialized_variables
var prediction;
String url = '';
int? val_age;

class Age extends StatefulWidget {
  const Age({Key? key}) : super(key: key);

  @override
  State<Age> createState() => _AgeState();
}

class _AgeState extends State<Age> {
  final ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.zero,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 40, bottom: 0),
                      child: Image.asset(
                        'assets/logo quiet zone.png',
                        height: 300,
                        width: 300,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 45),
                      alignment: Alignment.center,
                      transformAlignment: Alignment.center,
                      child: Text('Please enter \n your age',
                          style: appText(), textAlign: TextAlign.center),
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: Container(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: AgeInput(
                          ageController: ageController,
                        )),
                  ),
                  Flexible(
                      flex: 0,
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 20),
                        height: 120,
                        child: IconButton(
                          onPressed: () async {
                            await setAge(int.parse(ageController.text));
                            await getAge();
                            if (val_age != null) {
                              Navigator.push(
                                this.context,
                                MaterialPageRoute(
                                    builder: (context) => const Sound_meter()),
                              );
                            }
                            notif_request();
                            mic_permission();
                          },
                          icon: Image.asset('assets/login.png'),
                          iconSize: 150,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setAge(int val_age) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('val_age', val_age);
  }

  Future<void> getAge() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    val_age = pref.getInt('val_age');
  }

  Future<void> setTime(int notif_time) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('notif_time', 8);
  }
}
