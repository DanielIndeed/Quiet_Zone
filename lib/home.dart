// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import './recording_process.dart';
import 'utils/style/text.dart';
import 'utils/Permissions/permissions.dart';
import 'utils/Navig_bar/navig_bar.dart';

// Notification plugin
void main() => runApp(const MaterialApp(home: Home()));

var prediction;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
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
                        child: Image.asset('assets/start_animation.png'),
                      ),
                      Container(
                        alignment: AlignmentGeometry.lerp(
                            Alignment.centerLeft, Alignment.centerRight, 0.47),
                        padding: const EdgeInsets.only(),
                        margin: EdgeInsets.zero,
                        child: Text(
                          'Sleeping',
                          style: appText(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.zero,
                        height: 120,
                        padding: EdgeInsets.zero,
                        child: iconButtonWidget(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
              child: BottomNav(),
            )));
  }

  IconButton iconButtonWidget() {
    return IconButton(
      icon: Image.asset('assets/start_button.png'),
      iconSize: 150,
      padding: EdgeInsets.only(bottom: 20),
      onPressed: () async {
        mic_permission();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RecordingProcess()),
        );
      },
    );
  }
}
