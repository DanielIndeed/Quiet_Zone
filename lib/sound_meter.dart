import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/Navig_bar/navig_bar.dart';
import 'package:flutter_application_1/utils/style/text.dart';

class Sound_meter extends StatefulWidget {
  const Sound_meter({super.key});

  @override
  State<Sound_meter> createState() => _Sound_meterState();
}

class _Sound_meterState extends State<Sound_meter> {
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
                child: Text("Sound \n Meter", style: appText()),
              ),
            ]),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
              child: BottomNav(),
            )));
  }
}
