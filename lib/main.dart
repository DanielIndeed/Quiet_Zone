// ignore_for_file: non_constant_identifier_names, duplicate_ignore, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/Age_shared_preferences/age_input.dart';
import 'utils/Permissions/permissions.dart';
import 'dart:ui' as ui;
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

// ignore: prefer_typing_uninitialized_variables
var prediction;
String url = '';
int? val_age;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
                                    builder: (context) => const Home()),
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
}

TextStyle appText() {
  return TextStyle(
    fontSize: 50,
    fontStyle: FontStyle.italic,
    fontWeight: ui.FontWeight.w500, // use the ui prefix for FontWeight
    fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
    foreground: Paint()
      ..shader = ui.Gradient.linear(
        const Offset(50, 40),
        const Offset(150, 20),
        <Color>[
          const Color.fromRGBO(255, 106, 91, 1.0),
          const Color.fromRGBO(255, 206, 66, 1.0),
        ],
      ),
  );
}
