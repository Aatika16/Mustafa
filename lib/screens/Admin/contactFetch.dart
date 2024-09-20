import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/Widgets/AdminCommonDrawer.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/productsFetch.dart';

class ContactFetch extends StatefulWidget {
  final String name;
  final String email;
  final String Userid;
  final String contact;
  final String address;
  const ContactFetch(
      {super.key,
      required this.name,
      required this.email,
      required this.Userid,
      required this.contact,
      required this.address});

  @override
  State<ContactFetch> createState() => _ContactFetchState();
}

class _ContactFetchState extends State<ContactFetch> {
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
          await FirebaseFirestore.instance.collection('contact').get();

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
      body: Stack(
        children: [
          SizedBox(height: 15),
          Container(
            width: screenwidth * 1,
            padding: EdgeInsets.symmetric(horizontal: 30),
            margin: EdgeInsets.only(bottom: 10),
            child: Text("Customer Messages",
                textAlign: TextAlign.center,
                style: GoogleFonts.domine(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                )),
          ),
          SizedBox(height: 50),
          Container(
            margin: EdgeInsets.only(top: 50, left: 30, right: 30),
            child: productsData.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                    color: Colors.amber.shade400,
                  ))
                : ListView.builder(
                    itemCount: productsData.length,
                    itemBuilder: (context, index) {
                      final product = productsData[index];
                      return Column(
                        children: [
                          SizedBox(height: 20),
                          ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("Images/profileDefaultImg.jpg"),
                            ),
                            tileColor: Color.fromRGBO(255, 202, 40, 0.5),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['name'] ?? 'No Name',
                                  style: GoogleFonts.domine(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  product['email'] ?? 'No Email',
                                  style: GoogleFonts.domine(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              product['description'] ?? 'No Description',
                              style: GoogleFonts.domine(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                            isThreeLine: true,
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
