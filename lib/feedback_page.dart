// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/Navig_bar/navig_bar.dart';
import 'package:flutter_application_1/utils/style/text.dart';

class Feedback_page extends StatefulWidget {
  const Feedback_page({super.key});

  @override
  State<Feedback_page> createState() => _Feedback_pageState();
}

class _Feedback_pageState extends State<Feedback_page> {
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
                child: Text("Feedback", style: appText()),
              ),
            ]),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
              child: BottomNav(),
            )));
  }
}
