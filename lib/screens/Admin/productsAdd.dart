import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/productsFetch.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/Widgets/BeigeButton.dart';
import 'package:ecommerce_shoppe_app/Widgets/AdminCommonDrawer.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;

class ProductsAdd extends StatefulWidget {
  final String name;
  final String email;
  final String Userid;
  final String contact;
  final String address;
  const ProductsAdd(
      {super.key,
      required this.name,
      required this.email,
      required this.Userid,
      required this.contact,
      required this.address});

  @override
  State<ProductsAdd> createState() => _ProductsAddState();
}

class _ProductsAddState extends State<ProductsAdd> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  html.File? _webImage;
  //Successfull added data msg displaying
  void successMessage(String successMsg) {
    final snackBar = SnackBar(
      content: Text(successMsg),
      backgroundColor: Constants.greyColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> pickImage() async {
    if (UniversalPlatform.isWeb) {
      // Handle web file picker
      html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
      uploadInput.accept = 'image/*';
      uploadInput.click();
      uploadInput.onChange.listen((e) {
        final files = uploadInput.files;
        if (files != null && files.isNotEmpty) {
          setState(() {
            _webImage = files.first;
          });
        }
      });
    } else {
      // Handle mobile file picker
      final ImagePicker _imagePicker = ImagePicker();
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }
  }

// Info Add
  Future<void> addDetails(
    String name,
    String price,
    String description,
  ) async {
    try {
      // Making users class to add further details
      final destinationReference =
          await FirebaseFirestore.instance.collection('Products').add({
        'productName': name,
        'price': price,
        'description': description,
      });
      if (UniversalPlatform.isAndroid) {
        print('Running on Android');
      } else if (UniversalPlatform.isIOS) {
        print('Running on iOS');
      } else if (UniversalPlatform.isWeb) {
        print('Running on Web');
      } else {
        print('Unknown platform');
      }
      final String destinationID = destinationReference.id;

      // Upload image to Firebase Storage
      if (UniversalPlatform.isWeb && _webImage != null) {
        final Reference storageReference = FirebaseStorage.instanceFor(
                bucket: "gs://shoppe-ecommerce.appspot.com")
            .ref()
            .child('products/$destinationID');

        final UploadTask uploadTask = storageReference.putBlob(_webImage);
        await uploadTask.whenComplete(() => print('File Uploaded'));
      } else if (_image != null) {
        final Reference storageReference = FirebaseStorage.instanceFor(
                bucket: "gs://shoppe-ecommerce.appspot.com")
            .ref()
            .child('products/$destinationID');

        final UploadTask uploadTask = storageReference.putFile(_image!);
        await uploadTask.whenComplete(() => print('File Uploaded'));
      } else {
        print('No file selected');
      }

      // Handle success
      String successMsg = 'Data added successfully';
      Navigator.pop(context);
      successMessage(successMsg);
      // Clear the selected image
      setState(() {
        _image = null;
      });
    } catch (error) {
      print(error);
      String successMsg = 'Error occurred!!';
      successMessage(successMsg);
    }
  }

  String? validatePrice(String? price) {
    RegExp priceRegex = RegExp(r'^\d{2,9}(\.\d{2,9})?$');
    final isPriceValid = priceRegex.hasMatch(price ?? '');
    if (!isPriceValid) {
      return 'Add price';
    }
    return null;
  }

  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController description = TextEditingController();

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
                          builder: (context) => ProductsFetch(
                              name: widget.name,
                              email: widget.email,
                              Userid: widget.Userid,
                              contact: widget.contact,
                              address: widget.address,)));
                },
                icon: Icon(
                  Icons.search_rounded,
                  size: 30,
                  color: Colors.black,
                )),
            SizedBox(
              width: 10,
            )
          ],
        ),
        drawer: CommonDrawer(
          name: widget.name,
          email: widget.email,
          Userid: widget.Userid,
          contact: widget.contact,
          address: widget.address,
        ),
        body: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 15),
                Container(
                  width: screenwidth * 1,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text("Add Products",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.domine(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                      )),
                ),
                SizedBox(height: 10),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30.2),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 150,
                          ),

                          // Product Name TextField
                          TextFormField(
                            validator: (city) => city!.length < 3
                                ? 'Invalid Product Name'
                                : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            cursorColor: Constants.blackColor,
                            controller: name,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Product Name',
                              hintStyle:
                                  TextStyle(color: Colors.amber.shade400),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.blackColor),
                                borderRadius: BorderRadius.circular(
                                    15), // Adjust the value for more rounded corners
                              ),
                              // Remove the default border
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.amber.shade400),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors
                                        .red), // Customize the error border color
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors
                                        .red), // Customize the focused error border color
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                            ),
                            style: TextStyle(
                              color: Colors.amber.shade400,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          // Product Price
                          TextFormField(
                            validator: validatePrice,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            cursorColor: Constants.blackColor,
                            controller: price,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Product Price',
                              hintStyle:
                                  TextStyle(color: Colors.amber.shade400),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.blackColor),
                                borderRadius: BorderRadius.circular(
                                    15), // Adjust the value for more rounded corners
                              ),
                              // Remove the default border
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.amber.shade400),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors
                                        .red), // Customize the error border color
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors
                                        .red), // Customize the focused error border color
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                            ),
                            style: TextStyle(
                              color: Colors.amber.shade400,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          // Image Input Field
                          GestureDetector(
                            onTap: pickImage,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image,
                                      color: Colors.amber.shade400),
                                  SizedBox(width: 10),
                                  Text(
                                    _image == null
                                        ? 'Select Image'
                                        : 'Image Selected',
                                    style: TextStyle(
                                      color: Constants.beigeColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // if (_image != null) ...[
                          //   SizedBox(height: 20),
                          //   Image.file(
                          //     _image!,
                          //     height: 150,
                          //   ),
                          // ],

                          const SizedBox(
                            height: 10,
                          ),
                          // Description TextFormField
                          TextFormField(
                            maxLines:
                                4, // Set the maximum number of lines for the description box
                            validator: (description) => description!.isEmpty
                                ? 'Please enter a description'
                                : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            cursorColor: Constants.blackColor,
                            controller: description,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Product Description',
                              hintStyle:
                                  TextStyle(color: Colors.amber.shade400),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(
                                    15), // Adjust the value for more rounded corners
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.blackColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors
                                        .red), // Customize the error border color
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors
                                        .red), // Customize the focused error border color
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                            ),
                            style: TextStyle(
                              color: Colors.amber.shade400,
                            ),
                          ),

                          BeigeButton(
                              topBottomPadding: 20,
                              leftRightPadding: 10,
                              widget_: Text(
                                "Add Product",
                                style: GoogleFonts.domine(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18),
                              ),
                              OntapFunction: () {
                                if (_formKey.currentState!.validate()) {
                                  addDetails(
                                      name.text, price.text, description.text);
                                }
                              },
                              topBottomMargin: 10,
                              leftRightMargin: 0)
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
