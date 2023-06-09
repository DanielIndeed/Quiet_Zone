// ignore_for_file: non_constant_identifier_names, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'dart:ui' as ui;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'age_input.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

void notif_permission() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (await Permission.notification.isPermanentlyDenied) {
    openAppSettings();
  } else if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}

void mic_permission() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (await Permission.microphone.isPermanentlyDenied) {
    openAppSettings();
  } else if (await Permission.microphone.isDenied) {
    await Permission.microphone.request();
  }
}

// ignore: prefer_typing_uninitialized_variables
var prediction;
var data;
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
        body: Column(
          children: [
            Flexible(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: EdgeInsets.zero,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 70),
                      child: Image.asset(
                        'assets/logo quiet zone.png',
                        height: 300,
                        width: 300,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.zero,
                      alignment: Alignment.center,
                      transformAlignment: Alignment.center,
                      child: Text('Please enter your age',
                          style: appText(), textAlign: TextAlign.center),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 50, top: 20, right: 50),
                    child: AgeInput(ageController: ageController),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.zero,
                    height: 120,
                    child: IconButton(
                      onPressed: () async {
                        permission_requests();
                        setAge(int.parse(ageController.text));
                        print(val_age);
                        await getAge();
                        if (val_age != null) {
                          print(val_age);
                          Navigator.push(
                            this.context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        }
                      },
                      icon: Image.asset('assets/start_button.png'),
                      iconSize: 150,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle appText() {
    return TextStyle(
      fontSize: 47,
      fontStyle: FontStyle.italic,
      fontWeight: ui.FontWeight.w500,
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

  Future<void> permission_requests() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
    if (await Permission.microphone.isDenied) {
      await Permission.microphone.request();
    }
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
