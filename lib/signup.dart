// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/utils/Navig_bar/navig_bar.dart';
import 'package:flutter_application_1/utils/style/text.dart';
import 'package:intl/intl.dart';

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
            body: Column(children: [
              Flexible(
                  flex: 2,
                  child: Column(children: <Widget>[
                    Flexible(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.zero,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 55),
                          child: Image.asset(
                            'assets/logo quiet zone.png',
                            height: 160,
                            width: 160,
                          ),
                        )),
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
                              height: height * 0.05,
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
                              readOnly: true,
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
                                        .then((value) {
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
                          ],
                        ),
                      ),
                    )
                  ]))
            ]),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
              child: BottomNav(),
            )));
  }
}
