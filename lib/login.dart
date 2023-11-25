// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/Navig_bar/navig_bar.dart';
import 'package:flutter_application_1/utils/style/text.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
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
            body: Column(children: [
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
                height: height*0.125,
              ),
              Container(
                margin: EdgeInsets.zero,
                alignment: Alignment.center,
                child: Text("Login", style: appText()),
              ),
              Container(
                width: width*0.8,
                margin: EdgeInsets.zero,
                alignment: Alignment.center,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height*0.025,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email adress",
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                          ),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelStyle: TextStyle(color: defColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: defColor)
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value!.isEmpty) {

                          }
                        },
                      ),
                      SizedBox(
                        height: height*0.025,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                          ),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelStyle: TextStyle(color: defColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: defColor)
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {

                          }
                        },
                      ),
                      SizedBox(
                        height: height*0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Image.asset(
                              'assets/login.png',
                              fit: BoxFit.cover,
                            ),
                            iconSize: 180,
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => const MyApp()),
                              // );
                            },
                            constraints: const BoxConstraints(maxWidth: 300, maxHeight: 65),
                          ),
                        ],
                        
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
              child: BottomNav(),
            )));
  }
}
