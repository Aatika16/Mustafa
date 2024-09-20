import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_shoppe_app/screens/User/productDetails.dart';
import 'package:ecommerce_shoppe_app/screens/User/searchScreen.dart';

String? email;
String? name;

class Dashboard extends StatefulWidget {
  final String name;
  final String email;
  final String Userid;
  final String contact;
  const Dashboard({
    super.key,
    required this.name,
    required this.email,
    required this.Userid,
    required this.contact,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;

  int _currentIndex = 0;
  List<Map<String, dynamic>> productsData = [];

  @override
  void initState() {
    super.initState();
    getEmail_via_Sp();
    getName_via_Sp();
    fetchProductsData();
  }

  void getEmail_via_Sp() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    setState(() {
      email = shared.getString("sp_email");
    });
  }

  void getName_via_Sp() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    setState(() {
      name = shared.getString("sp_name");
    });
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
      
      body: Container(
        width: screenwidth * 1,
        height: screenheight * 1,
        margin: EdgeInsets.only(top: 15),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              // Above Text
              Container(
                width: screenwidth * 1,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text("What did you want?",
                    style: GoogleFonts.domine(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    )),
              ),
              SizedBox(height: 20),
              // Search Field
              Container(
                width: screenwidth * 1,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen(
                                name: widget.name,
                                email: widget.email,
                                Userid: widget.Userid,
                                contact: widget.contact)));
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      border: Border.all(color: Colors.amber.shade400),
                      borderRadius: BorderRadius.circular(
                          50), // Adjust the value for more rounded corners
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Search.......',
                          style: GoogleFonts.domine(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: screenwidth * 1,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text("Featured Products",
                    style: GoogleFonts.domine(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    )),
              ),
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
                        margin:
                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 6),
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
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: screenwidth * 1,
                  height: screenheight * 0.1,
                  color: Color.fromRGBO(255, 202, 40, 0.5),
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.amber.shade400,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Colors.black)),
                            padding: EdgeInsets.only(
                                left: 5, top: 5, bottom: 5, right: 5),
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            height: screenheight * 0.1,
                            width: 50,
                            child: Center(
                              child: Text(
                                "All",
                                style: GoogleFonts.domine(
                                    fontSize: 18, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.amber.shade400,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Colors.black)),
                            padding: EdgeInsets.only(
                                left: 5, top: 5, bottom: 5, right: 5),
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            height: screenheight * 0.1,
                            width: 100,
                            child: Center(
                              child: Text(
                                "Shoes",
                                style: GoogleFonts.domine(
                                    fontSize: 18, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.amber.shade400,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Colors.black)),
                            padding: EdgeInsets.only(
                                left: 5, top: 5, bottom: 5, right: 5),
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            height: screenheight * 0.1,
                            width: 100,
                            child: Center(
                              child: Text(
                                "Watches",
                                style: GoogleFonts.domine(
                                    fontSize: 18, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.amber.shade400,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Colors.black)),
                            padding: EdgeInsets.only(
                                left: 5, top: 5, bottom: 5, right: 5),
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            height: screenheight * 0.1,
                            width: 100,
                            child: Center(
                              child: Text(
                                "Bags",
                                style: GoogleFonts.domine(
                                    fontSize: 18, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.amber.shade400,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Colors.black)),
                            padding: EdgeInsets.only(
                                left: 5, top: 5, bottom: 5, right: 5),
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            height: screenheight * 0.1,
                            width: 100,
                            child: Center(
                              child: Text(
                                "Caps",
                                style: GoogleFonts.domine(
                                    fontSize: 18, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.amber.shade400,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Colors.black)),
                            padding: EdgeInsets.only(
                                left: 5, top: 5, bottom: 5, right: 5),
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            height: screenheight * 0.1,
                            width: 100,
                            child: Center(
                              child: Text(
                                "Rings",
                                style: GoogleFonts.domine(
                                    fontSize: 18, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.amber.shade400,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Colors.black)),
                            padding: EdgeInsets.only(
                                left: 5, top: 5, bottom: 5, right: 5),
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            height: screenheight * 0.1,
                            width: 100,
                            child: Center(
                              child: Text(
                                "Head phones",
                                style: GoogleFonts.domine(
                                    fontSize: 18, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.amber.shade400,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Colors.black)),
                            padding: EdgeInsets.only(
                                left: 5, top: 5, bottom: 5, right: 5),
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            height: screenheight * 0.1,
                            width: 100,
                            child: Center(
                              child: Text(
                                "Pants",
                                style: GoogleFonts.domine(
                                    fontSize: 18, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),

              // Explore Product Text
              SizedBox(
                height: 10,
              ),

              Container(
                width: screenwidth * 1,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text("Latest Collection",
                    style: GoogleFonts.domine(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    )),
              ),
              SizedBox(
                height: 10,
              ),

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
                                        child:
                                         Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2),
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          product['data']
                                                              ['productName'],
                                                          style: GoogleFonts
                                                              .domine(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black)),
                                                      Text(
                                                          "Rs:  ${product['data']['price']} ",
                                                          style: GoogleFonts
                                                              .domine(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black)),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(bottom: 15),
                                                        padding: EdgeInsets.symmetric(horizontal: 15),
                                                        width: screenwidth * 1,
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
                                                                              widget.contact)));
                                                            },
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    WidgetStatePropertyAll(
                                                                        Colors
                                                                            .amber
                                                                            .shade400)),
                                                            child: Text(
                                                                "View More",
                                                                style: GoogleFonts
                                                                    .domine(
                                                                        fontSize:
                                                                            18,
                                                                        color: Colors
                                                                            .black))),
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
      ),

      // Navigation Bar
      
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
