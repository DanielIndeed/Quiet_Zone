// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, depend_on_referenced_packages, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/style/text.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'age.dart';
import 'login.dart';
// import 'package:path/path.dart';

class SignUp extends StatefulWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    const Color defColor = Color.fromARGB(255, 238, 109, 65);

    // TextEditingController dateController = TextEditingController();
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2024),
      );
      if (picked != null) {
        setState(() {
          // Update the TextEditingController with the selected date
          widget.dateController.text = DateFormat('dd-MM-yyyy').format(picked);
          print(widget.dateController.text);
        });

        // Unfocus the TextFormField
        FocusScope.of(context).unfocus();
      }
    }

    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        home: Scaffold(
          body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                Column(children: <Widget>[
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
                    child: Text("SignUp", style: appText()),
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
                              height: height * 0.03,
                            ),
                            TextField(
                              controller: widget.usernameController,
                              decoration: InputDecoration(
                                labelText: "Username",
                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                                floatingLabelStyle: TextStyle(color: defColor),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: defColor)),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: height * 0.025,
                            ),
                            TextField(
                              readOnly: false,
                              controller: widget.dateController,
                              decoration: InputDecoration(
                                labelText: 'Birth date',
                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                                floatingLabelStyle: TextStyle(color: defColor),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: defColor)),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () {},
                                ),
                              ),
                              onTap: () async {
                                _selectDate(context);
                              },
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: height * 0.025,
                            ),
                            TextField(
                              controller: widget.emailController,
                              decoration: InputDecoration(
                                labelText: "Email adress",
                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                                floatingLabelStyle: TextStyle(color: defColor),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: defColor)),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: height * 0.025,
                            ),
                            TextField(
                              controller: widget.passwordController,
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                                floatingLabelStyle: TextStyle(color: defColor),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: defColor)),
                              ),
                              style: TextStyle(color: Colors.white),
                              obscureText: true,
                            ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Image.asset(
                                    'assets/logout.png',
                                    fit: BoxFit.cover,
                                  ),
                                  iconSize: 180,
                                  onPressed: () {
                                    FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: widget.emailController.text,
                                            password:
                                                widget.passwordController.text)
                                        .then((value) async {
                                      FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(value.user!.uid)
                                          .set({
                                        'Birthdate': widget.dateController.text
                                            .toString()
                                      });
                                      val_age = await calculateAge();
                                      setAge(val_age!);
                                      Navigator.push(
                                        this.context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()),
                                      );
                                    });
                                  },
                                  constraints: const BoxConstraints(
                                      maxWidth: 300, maxHeight: 65),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: "Already have an account? ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  TextSpan(
                                      text: "Sign in",
                                      style: TextStyle(color: Colors.orange),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login()),
                                          );
                                        })
                                ])),
                              ],
                            ),
                          ],
                        ),
                      )),
                ])
              ])),
        ));
  }

  Future<int> calculateAge() async {
    // ignore: unused_local_variable
    DateTime now = DateTime.now();
    DateTime birthdate = dateFormat.parse(widget.dateController.text);
    int val_age = now.year - birthdate.year;
    int month1 = now.month;
    int month2 = birthdate.month;
    if (month2 > month1) {
      val_age--;
    } else if (month1 == month2) {
      int day1 = now.day;
      int day2 = birthdate.day;
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
