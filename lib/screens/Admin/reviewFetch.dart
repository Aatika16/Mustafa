import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/Widgets/AdminCommonDrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/adminDashboard.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/productsFetch.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/userDetails.dart';

class ReviewFetch extends StatefulWidget {
  final String name;
  final String email;
  final String Userid;
  final String contact;
  final String address;
  const ReviewFetch(
      {super.key,
      required this.name,
      required this.email,
      required this.Userid,
      required this.contact,
      required this.address});

  @override
  State<ReviewFetch> createState() => _ReviewFetchState();
}

class _ReviewFetchState extends State<ReviewFetch> {
  int selectedIndex = 3;
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
          await FirebaseFirestore.instance.collection('review').get();

      List<Map<String, dynamic>> fetchedProductsData = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;
        fetchedProductsData.add(productData);
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
          address: widget.address,),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 15),
            Container(
              width: screenwidth * 1,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text("All Reviews",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.domine(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                  )),
            ),
            SizedBox(height: 10),
            Container(
              child: productsData.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(
                      color: Colors.amber.shade400,
                    ))
                  : Container(
                      height: 600, // Set a fixed height for the ListView
                      child: ListView.builder(
                        itemCount: productsData.length,
                        itemBuilder: (context, index) {
                          final product = productsData[index];
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(
                                    10), // Adjust margin as needed
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(255, 202, 40, 0.5),
                                  borderRadius: BorderRadius.circular(
                                      20), // Adjust radius as needed
                                  border: Border.all(
                                    color: Colors.amber
                                        .shade400, // Adjust border color as needed
                                    width: 2, // Adjust border width as needed
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      20), // Ensure the ListTile also gets clipped
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                          "Images/profileDefaultImg.jpg"),
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product['name'],
                                          style: GoogleFonts.domine(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          product['review'],
                                          style: GoogleFonts.domine(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                        ),
                                        Image.asset("Images/review.png")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),

      // Navigation Bar
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
                            address: widget.address)));
              } else if (index == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserDetails(
                            name: widget.name,
                            email: widget.email,
                            Userid: widget.Userid,
                            contact: widget.contact,
                            address: widget.address)));
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
