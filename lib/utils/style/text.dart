import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appText() {
  return TextStyle(
    fontSize: 50,
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
