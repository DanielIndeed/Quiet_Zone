import 'package:flutter/material.dart';
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
          backgroundColor: Colors.black,
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
          icon: Icon(
            Icons.person,
            color: Color.fromARGB(255, 238, 109, 65),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: Color.fromARGB(255, 238, 109, 65),
          ),
          label: '',
        ),
      ],
      backgroundColor: Colors.black,
      onTap: (index) {
        onTabTapped(context, index); // Pass the context to the function
      },
    );
  }

  void onTabTapped(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Settings()),
      );
    } else if (index == 2) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Sound_meter()),
      );
    } else if (index == 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Sonic_Hues()),
      );
    } else if (index == 4) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Profile()),
      );
    } else if (index == 4) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Settings()),
      );
    }
  }
}
