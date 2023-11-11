// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'dart:ui' as ui;
import 'package:flutter_application_1/utils/Navig_bar/navig_bar.dart';
import 'package:flutter_application_1/utils/style/text.dart';
import 'package:flutter_picker/picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

int? notif_time;

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
        ),
        home: Scaffold(
            body: Column(children: [
              Container(
                margin: EdgeInsets.zero,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 55),
                child: Image.asset(
                  'assets/logo quiet zone.png',
                  height: 160,
                  width: 160,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 5),
                alignment: Alignment.center,
                child: Text("Settings", style: appText()),
              ),
              Container(
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.person,
                    size: 100,
                    color: Color.fromRGBO(255, 106, 91, 1.0),
                  )),
              IconButton(
                icon: Image.asset(
                  'assets/logout.png',
                  fit: BoxFit.cover,
                ),
                iconSize: 180,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()),
                  );
                },
                constraints: const BoxConstraints(maxWidth: 300, maxHeight: 65),
              ),
              const Divider(
                height: 40,
                color: Color.fromRGBO(255, 106, 91, 1.0),
                thickness: 2,
                indent: 30,
                endIndent: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Notification Time",
                      style: notifText(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: const CircleBorder()),
                    child: Ink(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(255, 106, 91, 1.0),
                            Color.fromRGBO(255, 206, 66, 1.0),
                          ]),
                          borderRadius:
                              BorderRadius.all(Radius.circular(80.0))),
                      child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 70.0,
                              minHeight:
                                  36.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: const Icon(Icons.notifications)),
                    ),
                    onPressed: () {
                      showPickerNumber(context);
                    },
                  ),
                ],
              ),
              const Divider(
                height: 40,
                color: Color.fromRGBO(255, 106, 91, 1.0),
                thickness: 2,
                indent: 30,
                endIndent: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Spotify link",
                      style: notifText(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: const CircleBorder()),
                    child: Ink(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(99, 255, 91, 1),
                            Color.fromRGBO(209, 254, 104, 1),
                          ]),
                          borderRadius:
                              BorderRadius.all(Radius.circular(80.0))),
                      child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 70.0,
                              minHeight:
                                  36.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: const Icon(Icons.link)),
                    ),
                    onPressed: () {
                      showPickerNumber(context);
                    },
                  ),
                ],
              ),
              const Divider(
                height: 40,
                color: Color.fromRGBO(255, 106, 91, 1.0),
                thickness: 2,
                indent: 30,
                endIndent: 30,
              ),
            ]),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
              child: BottomNav(),
            )));
  }

  Future<void> setTime(int notif_time) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('notif_time', notif_time);
  }

  Future<void> getTime() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    notif_time = pref.getInt('notif_time');
  }

  showPickerNumber(BuildContext context) {
    Picker(
        adapter: NumberPickerAdapter(data: [
          const NumberPickerColumn(begin: 0, end: 96),
        ]),
        delimiter: [
          PickerDelimiter(
              child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: const Icon(Icons.more_vert),
          ))
        ],
        hideHeader: true,
        title: const Text(
            "Select the time in hours to have between your notifications"),
        onConfirm: (Picker picker, List value) {
          setTime(value[0]);
          print(value.toString());
          print(picker.getSelectedValues());
        }).showDialog(context);
  }
}
