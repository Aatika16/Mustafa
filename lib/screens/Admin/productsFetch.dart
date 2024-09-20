import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/Widgets/AdminCommonDrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/adminDashboard.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/reviewFetch.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/userDetails.dart';

class ProductsFetch extends StatefulWidget {
  final String name;
  final String email;
  final String Userid;
  final String contact;
  final String address;

  const ProductsFetch({
    super.key,
    required this.name,
    required this.email,
    required this.Userid,
    required this.contact,
    required this.address,
  });

  @override
  State<ProductsFetch> createState() => _ProductsFetchState();
}

class _ProductsFetchState extends State<ProductsFetch> {
  int selectedIndex = 1;
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
      print('Error fetching products data: $e');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      // Delete document from Firestore
      await FirebaseFirestore.instance
          .collection('Products')
          .doc(productId)
          .delete();
      print('Document deleted successfully from Firestore');

      // Create a reference to the file to delete in Firebase Storage
      Reference storageReference = FirebaseStorage.instanceFor(
              bucket: "gs://shoppe-ecommerce.appspot.com")
          .ref()
          .child('products/$productId');

      // Delete the file from Firebase Storage
      await storageReference.delete();
      print('File deleted successfully from Firebase Storage');

      // Remove the product from the local list
      setState(() {
        productsData
            .removeWhere((product) => product['productId'] == productId);
      });
    } catch (e) {
      print('Error deleting product: $e');
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
                        builder: (context) => ProductsFetch(
                              name: widget.name,
                              email: widget.email,
                              Userid: widget.Userid,
                              contact: widget.contact,
                              address: widget.address,
                            )));
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
          SizedBox(height: 10),
          Container(
            height: screenheight * 0.68,
            child: productsData.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                    color: Colors.amber.shade400,
                  ))
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 30.2),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: productsData.map(
                        (product) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
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
                                          onTap: () {
                                            print(
                                                "${product['data']['productName']} tapped");
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 202, 40, 0.7),
                                              border: Border.all(
                                                color: Colors
                                                    .black, // Adjust border color
                                                width: 2.0,
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                  20), // Adjust border radius
                                            ),
                                            margin: EdgeInsets.only(left: 20),
                                            width: 160,
                                            height: 160,
                                            child: Image.network(
                                              product['imageUrl'],
                                              height: 160,
                                            ), // Ensure image  fits within container
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Expanded(
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
                                                        255, 202, 40, 0.7),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  "${product['data']['productName']}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        255, 202, 40, 0.7),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  "${product['data']['description']}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        255, 202, 40, 0.7),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  "QUANTITY: 1",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        255, 202, 40, 0.7),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  "Rs: ${product['data']['price']}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Center(
                                                child: IconButton(
                                                  onPressed: () async {
                                                    await deleteProduct(
                                                        product['productId']);
                                                  },
                                                  icon: Icon(Icons.delete,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.amber.shade400, // Set your border color
            width: 1.0, // Set your border width
          ),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 15)],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
            color: Colors.amber,
            activeColor: Colors.black,
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              // Update the selected index
              setState(() {
                selectedIndex = index;
              });
              // Handle tab change
              if (index == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminDashboard(
                              name: widget.name,
                              email: widget.email,
                              Userid: widget.Userid,
                              contact: widget.contact,
                              address: widget.address,
                            )));
              } else if (index == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductsFetch(
                              name: widget.name,
                              email: widget.email,
                              Userid: widget.Userid,
                              contact: widget.contact,
                              address: widget.address,
                            )));
              } else if (index == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserDetails(
                              name: widget.name,
                              email: widget.email,
                              Userid: widget.Userid,
                              contact: widget.contact,
                              address: widget.address,
                            )));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReviewFetch(
                            name: widget.name,
                            email: widget.email,
                            Userid: widget.Userid,
                            contact: widget.contact,
                            address: widget.address)));
              }
            },
            tabBackgroundColor: Color.fromRGBO(255, 202, 40, 1),
            gap: 8,
            padding: EdgeInsets.all(11),
            tabs: const [
              GButton(icon: Icons.home, text: "Home"),
              GButton(icon: Icons.production_quantity_limits, text: "Products"),
              GButton(icon: Icons.account_circle, text: "Users"),
              GButton(icon: Icons.reviews, text: "Reviews"),
            ],
          ),
        ),
      ),
    );
  }
}
