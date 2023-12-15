// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter_application_1/utils/style/text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Login extends StatefulWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  DateTime? birthday_firestore;
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    const Color defColor = Color.fromARGB(255, 238, 109, 65);

    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      home: Scaffold(
          body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: <Widget>[
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
                SizedBox(
                  height: height * 0.08,
                ),
                Container(
                  margin: EdgeInsets.zero,
                  alignment: Alignment.center,
                  child: Text("Sign in", style: appText()),
                ),
                Container(
                  width: width * 0.8,
                  margin: EdgeInsets.zero,
                  alignment: Alignment.center,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.025,
                        ),
                        TextFormField(
                          controller: widget.emailController,
                          decoration: InputDecoration(
                            labelText: "Email adress",
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            floatingLabelStyle: TextStyle(color: defColor),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: defColor)),
                          ),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value!.isEmpty) {}
                          },
                        ),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        TextFormField(
                          controller: widget.passwordController,
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            floatingLabelStyle: TextStyle(color: defColor),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: defColor)),
                          ),
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {}
                          },
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Image.asset(
                                'assets/signin.png',
                                fit: BoxFit.cover,
                              ),
                              iconSize: 180,
                              onPressed: () {
                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: widget.emailController.text,
                                        password:
                                            widget.passwordController.text)
                                    .then((value) {
                                  FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(value.user!.uid)
                                      .get()
                                      .then((value) async {
                                    birthday_firestore =
                                        dateFormat.parse(value['Birthdate']);
                                    int val_age = await getAge();
                                    setAge(val_age);
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()),
                                  );
                                });
                              },
                              constraints: const BoxConstraints(
                                  maxWidth: 300, maxHeight: 65),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextSpan(
                      text: "Sign up",
                      style: TextStyle(color: Colors.orange),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        })
                ]))
              ]))),
    );
  }

  Future<int> getAge() async {
    // ignore: unused_local_variable
    DateTime now = DateTime.now();
    int val_age = now.year - birthday_firestore!.year;
    int month1 = now.month;
    int month2 = birthday_firestore!.month;
    if (month2 > month1) {
      val_age--;
    } else if (month1 == month2) {
      int day1 = now.day;
      int day2 = birthday_firestore!.day;
      if (day2 > day1) {
        val_age--;
      }
    }
    print(val_age);
    return val_age;
  }

  Future<void> setAge(int val_age) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('val_age', val_age);
  }
}
