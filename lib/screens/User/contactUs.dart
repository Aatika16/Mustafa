import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/Widgets/bottomnavigation.dart';
import 'package:ecommerce_shoppe_app/Widgets/userDrawer.dart';

class ContactUsScreen extends StatefulWidget {
  final String name;
  final String email;
  final String Userid;
  final String contact;
  const ContactUsScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.Userid,
      required this.contact});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
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

  // Info Add
  Future<void> addDetails(
    String name,
    String email,
    String description,
  ) async {
    try {
      // Making users class to add further details
      final destinationReference =
          await FirebaseFirestore.instance.collection('contact').add({
        'name': name,
        'email': email,
        'description': description,
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => BN(
              name: widget.name,
              email: widget.email,
              Userid: widget.Userid,
              contact: widget.contact)));
    } catch (error) {
      print(error);
    }
  }

  // Text controller
  final TextEditingController email = new TextEditingController();
  final TextEditingController description = new TextEditingController();
  final TextEditingController name = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Shop Pe",
            style: GoogleFonts.domine(
                fontSize: 32,
                wordSpacing: 5,
                letterSpacing: 3,
                height: 200,
                fontWeight: FontWeight.w900),
          ),
          backgroundColor: Colors.amber.shade400,
          foregroundColor: Colors.black,
          toolbarHeight: 70,
          centerTitle: true,
          bottomOpacity: 0.5,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      // color: Constants.greyColor, // Circle color
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset("Images/Hamburger-menu.png")),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BN(
                              name: widget.name,
                              email: widget.email,
                              Userid: widget.Userid,
                              contact: widget.contact)));
                },
                icon: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.black,
                )),
            SizedBox(
              width: 10,
            )
          ],
        ),
        drawer: UserCommonDrawer(
            name: widget.name,
            email: widget.email,
            Userid: widget.Userid,
            contact: widget.contact),
        body: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 15),
                Container(
                  width: screenwidth * 1,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text("Contact Us",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.domine(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                      )),
                ),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.2),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 150,
                          ),

                          //Product Name TextField
                          TextFormField(
                            validator: (city) =>
                                city!.length < 3 ? 'Invalid Name' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            cursorColor: Colors.amber.shade400,
                            controller: name,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              label: Text("Name"),
                              labelStyle: TextStyle(
                                  color: Colors.amber.shade400, fontSize: 20),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.blackColor),
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust the value for more rounded corners
                              ),
                              // Remove the default border
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.amber.shade400),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .red), // Customize the error border color
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .red), // Customize the focused error border color
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                            ),
                            style: TextStyle(
                              color: Colors.amber,
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          //Product Price
                          TextFormField(
                            validator: validateEmail,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            cursorColor: Constants.blackColor,
                            controller: email,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              label: Text("Email"),
                              labelStyle: TextStyle(
                                  color: Colors.amber.shade400, fontSize: 20),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.blackColor),
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust the value for more rounded corners
                              ),
                              // Remove the default border
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.amber.shade400),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .red), // Customize the error border color
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .red), // Customize the focused error border color
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                            ),
                            style: TextStyle(
                              color: Colors.amber,
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          // Description TextFormField
                          TextFormField(
                            maxLines:
                                6, // Set the maximum number of lines for the description box
                            validator: (description) => description!.length < 3
                                ? 'Please Enter A Description'
                                : null,
                            // validator: (description) => description!.isEmpty
                            //     ? 'Please enter a description'
                            //     : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: description,
                            cursorColor: Constants.blackColor,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              label: Text("Ask Any Thing Here"),
                              labelStyle: TextStyle(
                                  color: Colors.amber.shade400, fontSize: 20),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.blackColor),
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust the value for more rounded corners
                              ),
                              // Remove the default border
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.amber.shade400),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .red), // Customize the error border color
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .red), // Customize the focused error border color
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                            ),
                            style: TextStyle(
                              color: Colors.amber,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),

                          // BeigeButton(
                          //     topBottomPadding: 20,
                          //     leftRightPadding: 10,
                          //     widget_: Text("Add Product",style: TextStyle(color: Constants.blackColor,fontWeight: FontWeight.w900,fontSize: 16),),
                          //     OntapFunction: () {
                          //       print("working");
                          //     },
                          //     topBottomMargin: 10,
                          //     leftRightMargin:0)

                          //Profile Update button
                          InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                addDetails(
                                    name.text, email.text, description.text);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 15,
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
                                      horizontal:
                                          10), // Adjust the padding as needed
                                  child: Text(
                                    "Submit",
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
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
