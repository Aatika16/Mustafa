import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ecommerce_shoppe_app/screens/user/login.dart';
import 'package:ecommerce_shoppe_app/screens/user/signUp.dart';
//import 'package:shoppe_app/services/register.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // title: "City Caddy",
    home: Forget(),
  ));
}

class Forget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Forget();
  }
}

class _Forget extends State<Forget> {
  final _email = TextEditingController();
  final _auth = FirebaseAuth.instance;
  Future<void> sendPasswordResetLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  //---------------------------------- Form validation
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  //------------------------ Email Validate
  //------------------------ Email Validate
  String? emailvalidate(value) {
    if (value!.isEmpty) {
      return 'Please enter Email';
    }
    RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) {
      return 'Non-Valid Email';
    }
    return null;
  }

  void showResetPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Password Reset"),
          content:
              Text("Password reset email has been sent. Check your mailbox."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                Fluttertoast.showToast(msg: "Check your mail box");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // double screenwidth = MediaQuery.of(context).size.width;
    // double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Form(
      key: _formkey,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.amber,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image(
                image: AssetImage("images/background2.png"),
                fit: BoxFit.fitHeight,
                opacity: AlwaysStoppedAnimation(0.5),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black26,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          width: double.infinity,
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Forget Your Password",
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2, left: 40),
                          width: double.infinity,
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Don't Worry",
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 40),
                          width: double.infinity,
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Just Enter Your Email",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(left: 15, bottom: 15, top: 15),
                      width: double.infinity,
                      height: 300,
                      margin: EdgeInsets.only(left: 30, top: 10),
                      decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30)),
                          border: Border.all(
                              width: 5,
                              color: Colors.white,
                              strokeAlign: BorderSide.strokeAlignOutside)),
                      child: Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 193, 7, 0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30)),
                            border: Border.all(
                                width: 5,
                                color: Colors.white,
                                strokeAlign: BorderSide.strokeAlignOutside)),
                        width: double.infinity,
                        height: double.infinity,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: _email,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  label: Text("Email"),
                                  hintText: "Email",
                                  prefixIcon: Icon(
                                    Icons.mail,
                                    color: Colors.black,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 3)),
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter Email';
                                  }
                                  RegExp regex = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                  if (!regex.hasMatch(value)) {
                                    return 'Non-Valid Email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height:15),
                              Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      border: Border.all(
                                          color: Colors.white,
                                          width: 3,
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside)),
                                  child: TextButton(
                                    onPressed: () {
                                      _auth.sendPasswordResetEmail(
                                          email: _email.text);
                                      showResetPasswordDialog(context);
                                    },
                                    child: Text(
                                      "Send Mail",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      // decoration: BoxDecoration(
                      //     color: Colors.deepOrangeAccent[700],
                      //     borderRadius: BorderRadius.all(
                      //       Radius.circular(5),
                      //     ),
                      //     border: Border.all(
                      //         color: Colors.white,
                      //         width: 3,
                      //         strokeAlign: BorderSide.strokeAlignOutside)),
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => SignUp(),
                            ));
                          },
                          child: Text(
                            "",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                    child: Container(
                      // decoration: BoxDecoration(
                      //     color: Colors.deepOrangeAccent[700],
                      //     borderRadius: BorderRadius.all(
                      //       Radius.circular(5),
                      //     ),
                      //     border: Border.all(
                      //         color: Colors.white,
                      //         width: 3,
                      //         strokeAlign: BorderSide.strokeAlignOutside)),
                      width: double.infinity,
                      height: double.infinity,
                      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                      // padding:
                      //     EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              "don't have an account?",
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => SignUp(),
                                  ));
                                },
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "Click Here",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    ));
  }
}
