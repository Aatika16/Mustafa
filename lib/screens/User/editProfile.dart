import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';

class EditProfile extends StatefulWidget {
  final String name;
  final String email;
  final String Userid;
  final String contact;
  const EditProfile(
      {super.key,
      required this.email,
      required this.contact,
      required this.name,
      required this.Userid});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<Map<String, dynamic>> productsData = [];

//Error validating
  void showErrorMessage(String errorToShow) {
    final snackBar = SnackBar(
      content: Text(errorToShow),
      backgroundColor: Constants.greyColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Fetch all products data
  Future<void> fetchProductsData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      List<Map<String, dynamic>> fetchedProductsData = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;
        String productId = doc.id;

        fetchedProductsData.add({
          'contact': contact,
          'email': email,
          'username': username,
        });
      }

      setState(() {
        productsData = fetchedProductsData;
      });
    } catch (e) {
      print(e);
    }
  }

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

  //Contact Number Validation
  String? validateContact(String? contact) {
    RegExp contactRegex = RegExp(r'^\+92[0-9]{10}$');
    final iscontactValid = contactRegex.hasMatch(contact ?? '');
    if (!iscontactValid) {
      return 'Add number starting with\n+92';
    }
    return null;
  }

  // Text controller
  final TextEditingController email = TextEditingController();
  final TextEditingController contact = new TextEditingController();
  final TextEditingController username = new TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProductsData();
    // Set the initial value from your data source to the TextEditingController
    email.text = widget.email;
    username.text = widget.name;
    contact.text = widget.contact;
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            Container(
              width: screenwidth * 1,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text("Profile",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.domine(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                  )),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: ClipOval(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors
                      .transparent, // Set background color to transparent if you want to see the border
                  backgroundImage: AssetImage("Images/profileDefaultImg.jpg"),

                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors
                            .amber.shade400, // Set your desired border color
                        width: 4.0, // Set the width of the border
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Name field
                    TextFormField(
                      controller: username,
                      validator: (email) => email!.length < 3
                          ? 'Username should be atleast 3 characters'
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter Name',
                        hintStyle: TextStyle(color: Colors.amber),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the value for more rounded corners
                        ),
                        // Remove the default border
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.red, // Customize the error border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .red, // Customize the focused error border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                      ),
                      style: TextStyle(
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Contact field
                    TextFormField(
                      controller: contact,
                      validator: validateContact,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter Contact',
                        hintStyle: TextStyle(color: Colors.amber),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the value for more rounded corners
                        ),
                        // Remove the default border
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.red, // Customize the error border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .red, // Customize the focused error border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                      ),
                      style: TextStyle(
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Email field
                    TextFormField(
                      controller: email,
                      validator: validateEmail,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter Email',
                        hintStyle: TextStyle(color: Colors.amber),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the value for more rounded corners
                        ),
                        // Remove the default border
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.red, // Customize the error border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .red, // Customize the focused error border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                      ),
                      style: TextStyle(
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(height: 50),

                    //Profile Update button
                    InkWell(
                      onTap: () {
                        updateUserInformation();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade400,
                          borderRadius: BorderRadius.circular(
                              Constants.buttonBorderRadius),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 10), // Adjust the padding as needed
                            child: Text(
                              "Save Changes",
                              style: GoogleFonts.domine(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),

      // Navigation Bar
    );
  }

  // Function to update user information
  void updateUserInformation() {
    // Get the new values from the text controllers
    String newEmail = email.text;
    String newContact = contact.text;
    String newUsername = username.text;

    // Update user information in Firestore
    FirebaseFirestore.instance.collection('users').doc(widget.Userid).update({
      'email': newEmail,
      'contact': newContact,
      'username': newUsername,
    }).then((value) {
      // If update is successful, show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User information updated successfully!'),
        ),
      );
    }).catchError((error) {
      // If there's an error, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update user information: $error'),
        ),
      );
    });
  }
}
