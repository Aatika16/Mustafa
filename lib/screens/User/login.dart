import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/Widgets/bottomnavigation.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/adminDashboard.dart';
import 'package:ecommerce_shoppe_app/screens/User/forgetpass.dart';
import 'package:ecommerce_shoppe_app/screens/User/signUp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Validation
  final _formKey = GlobalKey<FormState>();

  // Email validation
  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  bool isHiddenPassword = true;

  // Password validation
  String? validatePwd(String? pwd) {
    RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{8,}$');
    final isPwdValid = passwordRegex.hasMatch(pwd ?? '');
    if (!isPwdValid) {
      return 'Password must be at least 8 characters\nand include both digits and alphabets';
    }
    return null;
  }

  //Login

  void loginbtn(String email, String pwd) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pwd,
      );
      //Fetching details
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      QuerySnapshot querySnapshot =
          await users.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Access the data of the first document (assuming there's only one match)
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
        String emailFromFirestore = userData['email'] ?? '';
        String usernameFromFirestore = userData['username'] ?? '';
        String idFromFirestore = userData['id'] ?? '';
        String contactFromFirestore = userData['contact'] ?? '';
        String addressFromFirestore = userData['address'] ?? '';

// Check the email and password for specific conditions

        //  final SharedPreferences sp = await SharedPreferences.getInstance();
        //         sp.setString("sp_email", email);  email= "mustufakashif370@gmail.com" password= "kashif123"
 
        if (email == "admin12@gmail.com" && pwd == "admin123") {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdminDashboard(
                    name: usernameFromFirestore,
                    email: emailFromFirestore,
                    Userid: idFromFirestore,
                    contact: contactFromFirestore,
                    address: addressFromFirestore,)),
          );
          print(email);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BN(
                    name: usernameFromFirestore,
                    email: emailFromFirestore,
                    Userid: idFromFirestore,
                    contact: contactFromFirestore)),
          );
        }
        print(contactFromFirestore);
        final SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString("sp_email", emailFromFirestore);
        sp.setString("sp_name", usernameFromFirestore);
        sp.setString("sp_contact", contactFromFirestore);

        // Print or use the retrieved data
        print('Email from Firestore: $emailFromFirestore');
        print('Username from Firestore: $usernameFromFirestore');
      } else {
        print('No matching documents');
      }
    } on FirebaseAuthException catch (e) {
      // Handle authentication errors
      String errorToShow;

      switch (e.code) {
        case 'user-not-found':
          errorToShow = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorToShow = 'Wrong password provided for that user.';
          break;
        case 'invalid-email':
          errorToShow = 'Email address is not valid.';
          break;
        default:
          errorToShow = 'Invalid Email or Password!';
          print("Errorrrrrrr: ${e.message}");
        // errorToShow = 'Authentication failed. ${e.message}';
      }

      showErrorMessage(errorToShow);
    } catch (e) {
      // Handle other errors
      String errorToShow = 'Invalid Email or Password!';
      print("Erorrrrr is: ${e}");
      showErrorMessage(errorToShow);
      Fluttertoast.showToast(msg: "Invalid Email or Password!");
    }
  }

  //Error validating
  void showErrorMessage(String errorToShow) {
    final snackBar = SnackBar(
      content: Text(errorToShow),
      backgroundColor: Constants.greyColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Text controller
  final TextEditingController email = TextEditingController();
  final TextEditingController pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
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
              image: AssetImage("Images/manshopping.png"),
              fit: BoxFit.fitHeight,
              opacity: AlwaysStoppedAnimation(0.5),
            ),
          ),
          Container(
            width: screenwidth * 1,
            height: screenheight * 1,
            color: Colors.black26,
          ),
          Center(
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.symmetric(),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 75), // Add some padding from the top
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            "Welcome Back,",
                            style: TextStyle(
                                fontSize: 42,
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            "Please Login to Continue.",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                            child: Container(
                                padding: EdgeInsets.only(
                                    left: 15, bottom: 15, top: 15),
                                width: double.infinity,
                                height: 430,
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
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            // Email field
                                            TextFormField(
                                              controller: email,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              decoration: InputDecoration(
                                                label: Text("Email"),
                                                hintText: "Email",
                                                prefixIcon: Icon(
                                                  Icons.mail,
                                                  color: Colors.black,
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.black,
                                                            width: 3)),
                                                labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                              validator: validateEmail,
                                            ),

                                            // Password field
                                            TextFormField(
                                              controller: pwd,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              obscureText: isHiddenPassword,
                                              decoration: InputDecoration(
                                                label: Text("Password"),
                                                hintText: "Password",
                                                prefixIcon: Icon(
                                                  Icons.lock_outline,
                                                  color: Colors.black,
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
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
                                                        isHiddenPassword =
                                                            false;
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
                                              validator: validatePwd,
                                            ),

                                            Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
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
                                                      loginbtn(
                                                          email.text, pwd.text);
                                                    }
                                                  },
                                                  child: Text(
                                                    "Login Me",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                )),
                                            // BeigeButton(
                                            //     topBottomPadding: 20,
                                            //     leftRightPadding: 10,
                                            //     widget_: Text(
                                            //       "LOGIN",
                                            //       style: TextStyle(
                                            //           color: Constants
                                            //               .blackColor,
                                            //           fontWeight:
                                            //               FontWeight.w900,
                                            //           fontSize: 16),
                                            //     ),
                                            //     OntapFunction: () async {
                                            //       if (_formKey.currentState!
                                            //           .validate()) {
                                            //         loginbtn(email.text,
                                            //             pwd.text);
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
                                                  "Don't have an account?",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    SignUp()));
                                                  },
                                                  child: Text(
                                                    " Sign up",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      decoration: TextDecoration
                                                          .underline,
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
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: screenwidth * 1,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          color: Colors.black38,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Forget your password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Forget()));
                                },
                                child: Text(
                                  " Reset Password",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
