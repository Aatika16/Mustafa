import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/Widgets/AdminCommonDrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/productsFetch.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/reviewFetch.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/userDetails.dart';
import 'package:ecommerce_shoppe_app/screens/User/Dashboard.dart';
import 'package:ecommerce_shoppe_app/screens/User/searchScreen.dart';

class AdminDashboard extends StatefulWidget {
  final String name;
  final String email;
  final String Userid;
  final String contact;
  final String address;
  const AdminDashboard(
      {super.key,
      required this.name,
      required this.email,
      required this.Userid,
      required this.contact,
      required this.address});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int selectedIndex = 0;
  int _currentIndex = 0;
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
    List<Widget> carouselItems = [
      buildCarouselItem(screenwidth, screenheight, 'images/headphones_2.png',
          'Special Discount', 'UpTo 50%', Colors.pink),
      buildCarouselItem(screenwidth, screenheight, 'images/bag_3.png',
          'Special Discount', 'UpTo 70%', Colors.purple),
      buildCarouselItem(screenwidth, screenheight, 'images/ring_4.png',
          'Special Discount', 'UpTo 50%', Colors.redAccent.shade400),
      buildCarouselItem(screenwidth, screenheight, 'images/womanshoe_3.png',
          'Special Discount', 'UpTo 40%', Colors.deepOrange),
    ];
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
                            address:widget.address,
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Welcome Admin",
                style: GoogleFonts.domine(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Welcome to Shop Pe, your one-stop shop for all things timekeeping! Browse our extensive collection of stylish and featured products to find the perfect thing.",
                style: GoogleFonts.domine(
                  color: Colors.black54,
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: screenheight * 0.35,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: carouselItems,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: carouselItems.map((item) {
                          int index = carouselItems.indexOf(item);
                          return Container(
                            width: 10,
                            height: 10,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? Color.fromRGBO(255, 202, 40, 1)
                                  : Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Container(
              width: screenwidth * 1,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text("All Products",
                  style: GoogleFonts.domine(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            //PRODUCTS DISPLAY
            productsData.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                    color: Colors.amber.shade400,
                  ))
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.2),
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Column(
                          children: productsData.map((product) {
                            return Column(
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            border: Border.all(
                                                color: Colors.black, width: 2),
                                            color: Colors.white),
                                        child: Column(
                                          children: [
                                            Container(
                                                margin: EdgeInsets.all(2),
                                                width: screenwidth * 0.45,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                child: Image(
                                                  image: NetworkImage(
                                                    product['imageUrl'],
                                                  ),
                                                  fit: BoxFit.contain,
                                                )),
                                            Container(
                                              width: screenwidth * 1,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20),
                                                  ),
                                                  color: Colors.white),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        product['data']
                                                            ['productName'],
                                                        style:
                                                            GoogleFonts.domine(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black)),
                                                    Text(
                                                        "Rs:  ${product['data']['price']} ",
                                                        style:
                                                            GoogleFonts.domine(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black)),
                                                    Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        "${product['data']['description']} ",
                                                        style:
                                                            GoogleFonts.domine(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black)),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                                SizedBox(height: 15),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),

      // Navigation Bar
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
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
                            address: widget.address,)));
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
                            contact: widget.contact,address: widget.address,)));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReviewFetch(
                            name: widget.name,
                            email: widget.email,
                            Userid: widget.Userid,
                            contact: widget.contact,address: widget.address,)));
              }
            },
            tabBackgroundColor: Color.fromRGBO(255, 202, 40, 1),
            gap: 8,
            padding: const EdgeInsets.all(11),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "Home",
                textStyle: TextStyle(),
              ),
              GButton(icon: Icons.production_quantity_limits, text: "Products"),
              GButton(icon: Icons.account_circle, text: "Users"),
              GButton(icon: Icons.reviews, text: "Reviews"),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCarouselItem(double screenwidth, double screenheight,
      String imagePath, String title, String subtitle, Color color) {
    return Container(
      width: screenwidth * 0.9,
      height: screenheight * 0.4,
      margin: EdgeInsets.only(top: 15, bottom: 5, left: 5, right: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: screenwidth * 0.9,
              height: screenheight * 0.2,
              child: Image.asset(
                imagePath,
                fit: BoxFit.fitHeight,
              ),
              //Image(image: AssetImage(imagePath)),
            ),
            //SizedBox(height: 10),
            Container(
              width: screenwidth * 0.9,
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: GoogleFonts.domine(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: screenwidth * 0.9,
              child: Text(
                textAlign: TextAlign.center,
                subtitle,
                style: GoogleFonts.domine(
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
