// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import '../../login.dart';
import '../../signup.dart';
import '../../sonic_hues.dart';
import '../../feedback.dart' as app_feedback;
import '../../settings.dart';
import '../../sound_meter.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(), // Replace with your actual content
      bottomNavigationBar: InkWell(
          child: Row(children: <Widget>[
        BottomNav(),
        const VerticalDivider(color: Colors.white, thickness: 1)
      ])),
    );
  }
}

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 30,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: Color.fromARGB(255, 238, 109, 65),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.headphones,
            color: Color.fromARGB(255, 238, 109, 65),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.hearing,
            color: Color.fromARGB(255, 238, 109, 65),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.black,
          icon: Icon(
            Icons.feedback,
            color: Color.fromARGB(255, 238, 109, 65),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.login_outlined,
            color: Color.fromARGB(255, 116, 54, 33),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.create,
            color: Color.fromARGB(255, 116, 54, 33),
          ),
          label: '',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.home, color: Color.fromARGB(255, 238, 109, 65)),
        //   label: '',
        // ),
      ],
      backgroundColor: Colors.black,
      onTap: (index) {
        onTabTapped(context, index); // Pass the context to the function
      },
    );
  }

  void onTabTapped(BuildContext context, int index) {
    late Widget route;
    if (index == 0) {
      route = Settings();
    } else if (index == 1) {
      route = Sonic_Hues();
    } else if (index == 2) {
      route = Sound_meter();
    } else if (index == 3) {
      route = app_feedback.Feedback();
    } else if (index == 4) {
      route = Login();
    } else if (index == 5) {
      route = SignUp();
    }
    
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => route,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          Offset begin;
          if (1.5 > index) {
            begin = Offset(-10.0, 0.0);
          }else if (1.5 < index) {
            begin = Offset(10.0, 0.0);
          }else {
            begin = Offset(0.0, 10.0);
          }
          var end = Offset.zero;
          var curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        }
      ),
    );
  }
}
