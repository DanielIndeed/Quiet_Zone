// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class AgeInput extends StatefulWidget {
  final TextEditingController ageController;

  const AgeInput({Key? key, required this.ageController}) : super(key: key);

  @override
  _AgeInputState createState() => _AgeInputState();
}

class _AgeInputState extends State<AgeInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.ageController,
      keyboardType: TextInputType.number,
      cursorHeight: 20,
      cursorWidth: 3,
      cursorColor: Colors.white,
      obscureText: false,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        hintText: 'Age',
        hintStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 247, 90, 58)),
        ),
      ),
    );
  }
}
