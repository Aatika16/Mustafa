import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/Widgets/bottomnavigation.dart';
import 'package:ecommerce_shoppe_app/Widgets/userDrawer.dart';
import 'package:ecommerce_shoppe_app/screens/User/productDetails.dart';
import 'package:ecommerce_shoppe_app/screens/User/searchScreen.dart';

class ProductsScreen extends StatefulWidget {
  final String name;
  final String email;
  final String Userid;
  final String contact;
  const ProductsScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.Userid,
      required this.contact});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Map<String, dynamic>> productsData = [];

  @override
  void initState() {
    super.initState();
    fetchProductsData();
  }

  // Fetch all products data
  Future<void> fetchProductsData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Products').get();

      List<Map<String, dynamic>> fetchedProductsData = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;
        String productId = doc.id;

        // Get image URL from Firebase Storage
        final Reference storageReference = FirebaseStorage.instanceFor(
                bucket: "gs://shoppe-ecommerce.appspot.com")
            .ref()
            .child('products/$productId');

        String imageUrl = await storageReference.getDownloadURL();

        fetchedProductsData.add({
          'productId': productId,
          'data': productData,
          'imageUrl': imageUrl,
        });
      }

      setState(() {
        productsData = fetchedProductsData;
      });
    } catch (e) {
      print(e);
    }
  }

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
      body: Column(
        children: [
          SizedBox(height: 15),
          Container(
            width: screenwidth * 1,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text("All Products",
                textAlign: TextAlign.center,
                style: GoogleFonts.domine(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                )),
          ),
          Container(
            height: screenheight * 0.8,
            child: productsData.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                    color: Colors.amber.shade400,
                  ))
                : SingleChildScrollView(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          Column(
                            children: productsData.map((product) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      width: screenwidth * 1,
                                      height: 250,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade300,
                                                offset: Offset(5, 5),
                                                blurRadius: 7),
                                            BoxShadow(
                                                color: Colors.grey.shade300,
                                                offset: Offset(-5, -5),
                                                blurRadius: 7)
                                          ]),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      255, 202, 40, 0.7),
                                                  border: Border.all(
                                                    color: Colors
                                                        .black, // Adjust border color
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // Adjust border radius
                                                ),
                                                margin:
                                                    EdgeInsets.only(left: 20),
                                                width: 160,
                                                height: 160,
                                                child: Image.network(
                                                  product['imageUrl'],
                                                  height: 160,
                                                ), // Ensure image fits within container
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              child: Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              255,
                                                              202,
                                                              40,
                                                              0.7),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                      ),
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        product['data']
                                                            ['productName'],
                                                        style:
                                                            GoogleFonts.domine(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              255,
                                                              202,
                                                              40,
                                                              0.7),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                      ),
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        "QUANTITY: + 1 -",
                                                        style:
                                                            GoogleFonts.domine(
                                                                color: Constants
                                                                    .greyColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 15),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              255,
                                                              202,
                                                              40,
                                                              0.7),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                      ),
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        "${product['data']['description']}",
                                                        style:
                                                            GoogleFonts.domine(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              255,
                                                              202,
                                                              40,
                                                              0.7),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                      ),
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        "${product['data']['price']}",
                                                        style:
                                                            GoogleFonts.domine(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                              width: 2),
                                                          color: Color.fromRGBO(
                                                              255, 202, 40, 1),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                      ),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          print(
                                                              'Product ID: ${product['productId']}');
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => ProductDetails(
                                                                      product:
                                                                          "${product['data']['productName']}",
                                                                      image: product[
                                                                          'imageUrl'],
                                                                      description:
                                                                          "${product['data']['description']}",
                                                                      price:
                                                                          "${product['data']['price']}",
                                                                      id:
                                                                          "${product['productId']}",
                                                                      name: widget
                                                                          .name,
                                                                      email: widget
                                                                          .email,
                                                                      Userid: widget
                                                                          .Userid,
                                                                      contact:
                                                                          widget
                                                                              .contact)));
                                                        },
                                                        child: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          "View Details",
                                                          style: GoogleFonts
                                                              .domine(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900),
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
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
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
