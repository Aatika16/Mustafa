import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/Widgets/cartItems.dart';
import 'package:ecommerce_shoppe_app/Widgets/global.dart' as globals;
import 'package:ecommerce_shoppe_app/screens/User/confirmOrderScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_shoppe_app/Widgets/bottomnavigation.dart';
import 'package:ecommerce_shoppe_app/Widgets/userDrawer.dart';

class ConfirmOrderDetails extends StatefulWidget {
  final String name;
  final String email;
  final String Userid;
  final String contact;
  final String Ordername;
  final String address;
  const ConfirmOrderDetails(
      {super.key,
      required this.name,
      required this.address,
      required this.email,
      required this.contact,
      required this.Ordername,
      required this.Userid});

  @override
  State<ConfirmOrderDetails> createState() => _ConfirmOrderDetailsState();
}

class _ConfirmOrderDetailsState extends State<ConfirmOrderDetails> {
  final _formKey = GlobalKey<FormState>();
  double SubtotalAmount = 0;
  double finalAmount = 0;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;
    final cart = globals.globalCart; // Fetch the global cart

    // Reset subtotal and final amount
    SubtotalAmount = 0;
    double deliveryFee = 200;
    double tax = 5;

    // Calculate subtotal
    cart.forEach((item) {
      double price = double.parse(item.price);
      SubtotalAmount += price * item.quantity;
    });

    // Calculate final amount
    finalAmount = SubtotalAmount + deliveryFee + tax;

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Container(
              width: screenwidth * 1,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text("Checkout",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.domine(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                  )),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                width: screenWidth * 0.9,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(5, 5),
                      blurRadius: 7),
                  BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(-5, -5),
                      blurRadius: 7)
                ]),
                child: Padding(
                  padding: const EdgeInsets.all(
                      15), // Add some padding inside the border
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Summary",
                        style: TextStyle(
                          color: Colors.amber.shade400,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          ...cart.map((item) => _buildCartItem(item)).toList(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                width: screenWidth * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Please confirm and submit your order",
                      style: GoogleFonts.domine(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "By clicking submit order, you agree to Terms of Use and Privacy Policy",
                      style: GoogleFonts.domine(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                width: screenWidth * 0.9,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(5, 5),
                      blurRadius: 7),
                  BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(-5, -5),
                      blurRadius: 7)
                ]),
                child: Padding(
                  padding: const EdgeInsets.all(
                      15), // Add some padding inside the border
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Details",
                        style: GoogleFonts.domine(
                          color: Colors.amber.shade400,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Subtotal",
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Rs. $SubtotalAmount",
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Delivery",
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Rs. $deliveryFee",
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Tax",
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Rs. $tax",
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Total",
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Rs. $finalAmount",
                            style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
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
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Color.fromRGBO(255, 202, 40, 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: TextButton(
                onPressed: () async {
                  await _saveOrderToFirestore(cart, finalAmount);
                  // Navigate to the next page or show a success message
                },
                child: Text(
                  textAlign: TextAlign.center,
                  "Submit My Order",
                  style: GoogleFonts.domine(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    double price = double.parse(item.price);
    double totalPerProduct = price * item.quantity;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "${item.quantity}    ${item.title}",
                style: GoogleFonts.domine(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
                overflow: TextOverflow.ellipsis, // Change overflow to ellipsis
              ),
            ),
            Spacer(),
            Text(
              "Rs. $totalPerProduct",
              style: GoogleFonts.domine(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Future<void> _saveOrderToFirestore(
      List<CartItem> cart, double finalAmount) async {
    // Create an order map to store in Firestore
    Map<String, dynamic> orderData = {
      'total': finalAmount,
      'details': cart
          .map((item) => {
                'product': item.title,
                'price': double.parse(item.price),
                'quantity': item.quantity,
                'total': double.parse(item.price) * item.quantity,
              })
          .toList(),
      'OrderBy': widget.Ordername,
      'email': widget.email,
      'contact': widget.contact,
      'address' : widget.address
    };

    // Save the order to Firestore
    await FirebaseFirestore.instance.collection('orders').add(orderData);
    setState(() {
      cart.clear();
    });

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ConfirmOrderScreen(
              name: widget.name,
              email: widget.email,
              Userid: widget.Userid,
              contact: widget.contact)),
    );
  }
}
