import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/Widgets/AdminCommonDrawer.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/productsFetch.dart';
import 'package:ecommerce_shoppe_app/screens/User/Dashboard.dart';

class OrderDetails extends StatefulWidget {
  final String orderBy;
  final String contact;
  final List<dynamic> products;
  final String email;
  final String total;
  final String address;
  const OrderDetails({
    super.key,
    required this.orderBy,
    required this.contact,
    required this.email,
    required this.address,
    required this.total,
    required this.products,
  });

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
              onPressed: () async {
                Navigator.pop(context);
              },
            );
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.amber.shade400,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Summary",
                        style: GoogleFonts.domine(
                          color: Colors.amber.shade400,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 200, // Set a fixed height for the ListView
                        child: ListView.builder(
                          itemCount: widget.products.length,
                          itemBuilder: (context, index) {
                            final product = widget.products[index];
                            print("Product $index: $product");

                            // Access the 'details' list
                            final details = product['details'] as List<dynamic>;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...details.map((detail) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${detail['quantity']}    ${detail['product']}",
                                              style: GoogleFonts.domine(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 16,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "Rs: ${detail['total']}",
                                            style: GoogleFonts.domine(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  );
                                }).toList(),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Container(
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.amber.shade400,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Details",
                        style: GoogleFonts.domine(
                          color: Colors.amber.shade400,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Order By: ",
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            widget.orderBy,
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Contact: ",
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            widget.contact,
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Email:",
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            widget.email,
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Address:",
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            widget.address,
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Total: ",
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            widget.total,
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Colors.amber.shade400)),
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Text(
                  'Back To Orders',
                  style: GoogleFonts.domine(
                      color: Colors.black, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
