import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:google_fonts/google_fonts.dart';
import './recording_process.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
                    padding: const EdgeInsets.only(top: 3),
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
                    padding: const EdgeInsets.only(top: 12),
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
                    child: iconButtonWidget(),
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
      fontSize: 50,
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

  IconButton iconButtonWidget() {
    return IconButton(
      icon: Image.asset('assets/start_button.png'),
      iconSize: 150,
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RecordingProcess()),
        );
      },
    );
  }
}
