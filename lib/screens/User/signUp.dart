import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/Widgets/BeigeButton.dart';
import 'package:ecommerce_shoppe_app/screens/User/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Validation
  final _formKey = GlobalKey<FormState>();

  bool isHiddenPassword = true;
  // Email validation
  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  //Contact Number Validation
  String? validateContact(String? contact) {
    RegExp contactRegex = RegExp(r'^\+92[0-9]{10}$');
    final iscontactValid = contactRegex.hasMatch(contact ?? '');
    if (!iscontactValid) {
      return 'Add number starting with +92';
    }
    return null;
  }

  // Password validation
  String? validatePwd(String? pwd) {
    RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{8,}$');
    final isPwdValid = passwordRegex.hasMatch(pwd ?? '');
    if (!isPwdValid) {
      return 'Min 8 character both digits and alphabets';
    }
    return null;
  }

  //Login Successful msg
  void successMessage(String successMsg) {
    final snackBar = SnackBar(
      content: Text(successMsg),
      backgroundColor: Constants.greyColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Text controller
  final TextEditingController email = TextEditingController();
  final TextEditingController pwd = TextEditingController();
  final TextEditingController contact = new TextEditingController();
  final TextEditingController username = new TextEditingController();

  //SignIn Function
  Future<void> signIn(
      String email, String pwd, String username, String contact) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pwd);

      // Making users class to add further details
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid) // Use user's UID as the document ID
          .set({
        'email': email,
        'id': credential.user!.uid,
        'username': username,
        'contact': contact
      });

      String successMsg = 'Account Created Successfully';
      successMessage(successMsg);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
      // username.clear();
      // this above will work but bete apne stateless widget
      // use ki hui hai 1 hr laga diya error dhundne mai
    } catch (error) {
      print("Error signing in: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amber.shade400,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            //padding: EdgeInsets.only( left: 10, right: 10),
            child: Image(
              //alignment: Alignment.bottomCenter,
              image: AssetImage("Images/womanshopping.png"),
              fit: BoxFit.fitHeight,
              opacity: AlwaysStoppedAnimation(0.5),
            ),
          ),
          Container(
            width: screenwidth * 1,
            height: screenheight * 1,
            color: Colors.black26,
          ),
          Container(
            width: screenSize.width,
            height: screenSize.height,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.symmetric(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 75), // Add some padding from the top
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                        "Glad To Meet You",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                        "Create your new account for future uses.",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 75),
                    Center(
                        child: Container(
                            padding:
                                EdgeInsets.only(left: 15, bottom: 15, top: 15),
                            width: double.infinity,
                            height: 550,
                            margin: EdgeInsets.only(left: 30, top: 10),
                            decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30)),
                                border: Border.all(
                                    width: 5,
                                    color: Colors.white,
                                    strokeAlign:
                                        BorderSide.strokeAlignOutside)),
                            child: Container(
                                margin: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 10),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 193, 7, 0),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30)),
                                    border: Border.all(
                                        width: 5,
                                        color: Colors.white,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside)),
                                width: double.infinity,
                                height: double.infinity,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Name field
                                        TextFormField(
                                          controller: username,
                                          validator: (email) => email!.length <
                                                  3
                                              ? 'Username should be atleast 3 characters'
                                              : null,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType: TextInputType.name,
                                          decoration: InputDecoration(
                                            label: Text("Name"),
                                            //hintText: "Name",
                                            prefixIcon: Icon(
                                              Icons.text_format_rounded,
                                              color: Colors.black,
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 3)),
                                            labelStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        ),

                                        SizedBox(height: 10),
                                        // Contact field
                                        TextFormField(
                                          controller: contact,
                                          validator: validateContact,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            label: Text("Contact No"),
                                            //hintText: "Contact No",
                                            prefixIcon: Icon(
                                              Icons.phone,
                                              color: Colors.black,
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 3)),
                                            labelStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        ),

                                        SizedBox(height: 10),
                                        // Email field
                                        TextFormField(
                                          controller: email,
                                          validator: validateEmail,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            label: Text("Email"),
                                            //hintText: "Email",
                                            prefixIcon: Icon(
                                              Icons.mail,
                                              color: Colors.black,
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 3)),
                                            labelStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        ),

                                        SizedBox(height: 10),
                                        // Password field
                                        TextFormField(
                                          controller: pwd,
                                          validator: validatePwd,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: isHiddenPassword,
                                          decoration: InputDecoration(
                                            label: Text("Password"),
                                            hintText: "Password",
                                            prefixIcon: Icon(
                                              Icons.lock_outline,
                                              color: Colors.black,
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 3)),
                                            labelStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  if (isHiddenPassword ==
                                                      true) {
                                                    isHiddenPassword = false;
                                                  } else {
                                                    isHiddenPassword = true;
                                                  }
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  Icons.remove_red_eye,
                                                  color: Colors.black,
                                                  weight: 5,
                                                )),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 3,
                                                    strokeAlign: BorderSide
                                                        .strokeAlignOutside)),
                                            child: TextButton(
                                              onPressed: () async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  await signIn(
                                                      email.text,
                                                      pwd.text,
                                                      username.text,
                                                      contact.text);
                                                }
                                              },
                                              child: Text(
                                                "Register Me",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            )),

                                        // BeigeButton(
                                        //     topBottomPadding: 20,
                                        //     leftRightPadding: 10,
                                        //     widget_: Text(
                                        //       "SIGN UP",
                                        //       style: TextStyle(
                                        //           color: Constants.blackColor,
                                        //           fontWeight: FontWeight.w900,
                                        //           fontSize: 16),
                                        //     ),
                                        //     OntapFunction: () async {
                                        //       if (_formKey.currentState!
                                        //           .validate()) {
                                        //         await signIn(
                                        //             email.text,
                                        //             pwd.text,
                                        //             username.text,
                                        //             contact.text);
                                        //       }
                                        //     },
                                        //     topBottomMargin: 10,
                                        //     leftRightMargin: 0),

                                        SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Already have a account?",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginScreen()));
                                              },
                                              child: Text(
                                                " Login",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w900,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
