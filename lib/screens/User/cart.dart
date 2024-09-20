import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/Widgets/cartItems.dart';
import 'package:ecommerce_shoppe_app/screens/User/cofirmOrderdetails.dart';
import 'package:ecommerce_shoppe_app/Widgets/global.dart' as globals;

class CartScreen extends StatefulWidget {
  final String name;
  final String email;
  final String Userid;
  final String contact;
  const CartScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.Userid,
      required this.contact});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController address = TextEditingController();
  final TextEditingController name = TextEditingController();
  final cart = globals.globalCart;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            width: screenwidth * 1,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text("My Cart",
                textAlign: TextAlign.center,
                style: GoogleFonts.domine(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Column(
                      children: [
                        // Name TextField
                        TextFormField(
                          validator: (name) => name!.length < 3
                              ? 'Please Enter A Valid Name'
                              : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorColor: Colors.amber.shade400,
                          controller: name,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            label: Text("Name"),
                            labelStyle: TextStyle(
                                color: Colors.amber.shade400, fontSize: 18),
                            fillColor: Colors.white,
                            // hintText: 'Your Name',
                            // hintStyle: TextStyle(color: Colors.white),
                            border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amber.shade400),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amber.shade400),
                            ),

                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          style: TextStyle(
                              color: Colors.amber.shade400, fontSize: 20),
                        ),
                        SizedBox(height: 15),
                        // Address TextField
                        TextFormField(
                          cursorColor: Constants.blackColor,
                          controller: address,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            label: Text("Address"),
                            labelStyle: TextStyle(
                                color: Colors.amber.shade400, fontSize: 18),
                            fillColor: Colors.white,
                            // hintText: 'Your Name',
                            // hintStyle: TextStyle(color: Colors.white),
                            border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amber.shade400),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amber.shade400),
                            ),

                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          style: TextStyle(
                              color: Colors.amber.shade400, fontSize: 20),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                    // Expanded widget to hold the scrollable product list
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...cart
                                .map((item) => _buildCartItem(item))
                                .toList(),
                          ],
                        ),
                      ),
                    ),
                    //Cart Checkout button

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          color: Color.fromRGBO(255, 202, 40, 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Process the order
                            print("Order Confirmed. Cart Items:");
                            for (var item in cart) {
                              print("${item.title}: ${item.quantity}");
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConfirmOrderDetails(
                                          name: widget.name,
                                          email: widget.email,
                                          Userid: widget.Userid,
                                          contact: widget.contact,
                                          address: address.text,
                                          Ordername: name.text,
                                        )));
                            // Clear the cart
                          }
                        },
                        child: Text(
                          textAlign: TextAlign.center,
                          "CheckOut",
                          style: GoogleFonts.domine(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
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
      // Navigation Bar
    );
  }

  Widget _buildCartItem(CartItem item) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: screenwidth * 1,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  print("${item.title} tapped");
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 202, 40, 0.5),
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: 190,
                  height: 190,
                  child: Center(
                    child: Image.network(
                      item.img,
                      height: 150,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.domine(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Rs: ${item.price} per piece",
                      style: GoogleFonts.domine(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    Row(children: [
                      Text(
                        "Quantity: ${item.quantity}",
                        style: GoogleFonts.domine(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      ),
                      SizedBox(width: 5),
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline,
                            color: Colors.black),
                        onPressed: () {
                          if (item.quantity > 1) {
                            setState(() {
                              item.quantity -= 1;
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon:
                            Icon(Icons.add_circle_outline, color: Colors.black),
                        onPressed: () {
                          setState(() {
                            item.quantity += 1;
                          });
                        },
                      ),
                    ])
                  ],
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
