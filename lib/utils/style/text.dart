import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appText() {
  return TextStyle(
    fontSize: 48,
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

TextStyle appText_smaller() {
  return TextStyle(
    fontSize: 41,
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

TextStyle notifText() {
  return TextStyle(
    fontSize: 28,
    fontStyle: FontStyle.italic,
    fontWeight: ui.FontWeight.w500, // use the ui prefix for FontWeight
    fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
    foreground: Paint()
      ..shader = ui.Gradient.linear(
        const Offset(10, 30),
        const Offset(150, 20),
        <Color>[
          const Color.fromRGBO(255, 106, 91, 1.0),
          const Color.fromRGBO(255, 206, 66, 1.0),
        ],
      ),
  );
}

TextStyle appText_smaller2() {
  return TextStyle(
    fontSize: 20,
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