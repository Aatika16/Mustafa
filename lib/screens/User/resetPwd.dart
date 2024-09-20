import 'package:flutter/material.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/Widgets/BeigeButton.dart';
import 'package:ecommerce_shoppe_app/screens/User/login.dart';

class ResetPwdScreen extends StatefulWidget {
    final String name;
  final String email;
  final String Userid;
  final String contact;
  const ResetPwdScreen({super.key, required this.name, required this.email, required this.Userid, required this.contact});

  @override
  State<ResetPwdScreen> createState() => _ResetPwdScreenState();
}

class _ResetPwdScreenState extends State<ResetPwdScreen> {
  // Validation
  final _formKey = GlobalKey<FormState>();

  // Password validation
  String? validatePwd(String? pwd) {
    RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{8,}$');
    final isPwdValid = passwordRegex.hasMatch(pwd ?? '');
    if (!isPwdValid) {
      return 'Password must be at least 8 characters\nand include both digits and alphabets';
    }
    return null;
  }

  // Confirm password validation
  String? validateConfirmPwd(String? confirmPwd) {
    if (confirmPwd != pwd.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Text controllers
  final TextEditingController pwd = TextEditingController();
  final TextEditingController repwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.blackColor,
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Images/login.png"), // Set background image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Constants.blackColor.withOpacity(0.5), // Adjust opacity here
              BlendMode.darken, // You can also experiment with other BlendMode options
            ),
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 55), // Add some padding from the top
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white,
                        width: 4.0, // Adjust the width of the bottom border
                      ),
                    ),
                  ),
                  child: Text(
                    "PUT YOUR\nINFORMATION             ",
                    style: TextStyle(
                      color: Constants.beigeColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 20, // Font size as specified
                    ),
                  ),
                ),
                SizedBox(height: 75),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Password field
                      TextFormField(
                        controller: pwd,
                        validator: validatePwd,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Constants.greyColor.withOpacity(0.5),
                          hintText: '     PASSWORD',
                          hintStyle: TextStyle(color: Constants.beigeColor),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.blackColor),
                            borderRadius: BorderRadius.circular(30.0), // Adjust the value for more rounded corners
                          ),
                          // Remove the default border
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.blackColor),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Constants.beigeColor, // Customize the error border color
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Constants.beigeColor, // Customize the focused error border color
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                        ),
                        style: TextStyle(
                          color: Constants.blackColor,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Confirm Password field
                      TextFormField(
                        controller: repwd,
                        validator: validateConfirmPwd,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Constants.greyColor.withOpacity(0.5),
                          hintText: '     CONFIRM PASSWORD',
                          hintStyle: TextStyle(color: Constants.beigeColor),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.blackColor),
                            borderRadius: BorderRadius.circular(30.0), // Adjust the value for more rounded corners
                          ),
                          // Remove the default border
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.blackColor),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Constants.beigeColor, // Customize the error border color
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Constants.beigeColor, // Customize the focused error border color
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                        ),
                        style: TextStyle(
                          color: Constants.blackColor,
                        ),
                      ),
                      SizedBox(height: 20),
                      BeigeButton(
                        topBottomPadding: 20,
                        leftRightPadding: 10,
                        widget_: Text(
                          "SIGN UP",
                          style: TextStyle(color: Constants.blackColor, fontWeight: FontWeight.w900, fontSize: 16),
                        ),
                        OntapFunction: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            print("Form is valid");
                          } else {
                            print("Form is invalid");
                          }
                        },
                        topBottomMargin: 10,
                        leftRightMargin: 0,
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 1,
                              width: 60, // Adjust the width according to your design
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                            ),
                            Text(
                              "Or Login with",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'myfonts',
                                fontSize: 12,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            Container(
                              height: 1,
                              width: 60, // Adjust the width according to your design
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              print("navigation btn");
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Constants.greyColor,
                                borderRadius: BorderRadius.circular(Constants.buttonBorderRadius),
                                border: Border.all(
                                  color: Constants.greyColor,
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Adjust the padding as needed
                                  child: Image.asset(
                                    'Images/facebook.png',
                                    height: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print("navigation btn");
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Constants.greyColor,
                                borderRadius: BorderRadius.circular(Constants.buttonBorderRadius),
                                border: Border.all(
                                  color: Constants.greyColor,
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Adjust the padding as needed
                                  child: Icon(
                                    Icons.apple,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print("navigation btn");
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Constants.greyColor,
                                borderRadius: BorderRadius.circular(Constants.buttonBorderRadius),
                                border: Border.all(
                                  color: Constants.greyColor,
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Adjust the padding as needed
                                  child: Image.asset(
                                    'Images/googleIcon.png',
                                    height: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have a account!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              " LOGIN",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
