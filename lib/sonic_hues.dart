// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/Navig_bar/navig_bar.dart';
import 'package:flutter_application_1/utils/style/text.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(home: Sonic_Hues()));

class Sonic_Hues extends StatefulWidget {
  const Sonic_Hues({Key? key}) : super(key: key);

  @override
  State<Sonic_Hues> createState() => _Sonic_Hues_State();
}

class _Sonic_Hues_State extends State<Sonic_Hues> {
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
              margin: EdgeInsets.zero,
              alignment: Alignment.center,
              child: Text("Sonic Hues", style: appText()),
            ),
          ]),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
            child: BottomNav(),
          ),
        ));
  }

  
}
