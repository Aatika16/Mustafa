import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/Widgets/bottomnavigation.dart';
import 'package:ecommerce_shoppe_app/Widgets/cartItems.dart';
import 'package:ecommerce_shoppe_app/Widgets/userDrawer.dart';
import 'package:ecommerce_shoppe_app/Widgets/global.dart' as globals;

class ProductDetails extends StatefulWidget {
  final String name;
  final String email;
  final String Userid;
  final String contact;
  final String product;
  final String image;
  final String description;
  final String price;
  final String id;
  const ProductDetails(
      {super.key,
      required this.product,
      required this.image,
      required this.description,
      required this.price,
      required this.id,
      required this.name,
      required this.email,
      required this.Userid,
      required this.contact});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
// Cart List to hold Cart Items
  List<CartItem> cart = [];

  void addToCart(String title, String price, String img) {
    setState(() {
      int index = cart.indexWhere((item) => item.title == title);
      if (index != -1) {
        cart[index].quantity += 1;
      } else {
        cart.add(CartItem(title: title, quantity: 1, price: price, img: img));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the width of the screen
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.2),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
              Container(
                width: screenwidth * 1,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text("Product Details",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.domine(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    )),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 202, 40, 0.5),
                  border: Border.all(
                    color: Colors.amber.shade400, // Adjust border color
                    width: 2,
                  ),
                  borderRadius:
                      BorderRadius.circular(30), // Adjust border radius
                ),
                width: double.maxFinite,
                height: 250,
                child: Image.network(
                  widget.image,
                  height: 150,
                ), // Ensure image fits within container
              ),
              SizedBox(height: 20), // Added space between the image and text
              Row(
                children: [
                  Expanded(
                    // Use Expanded to take available space
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      child: Text(
                        widget.product,
                        style: GoogleFonts.domine(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          textBaseline: TextBaseline.ideographic,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                  Spacer(),
                  //Image
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    child: Image.asset("Images/review.png"),
                  )
                ],
              ),

              SizedBox(
                height: 5,
              ),

              Row(
                children: [
                  Expanded(
                    // Use Expanded to take available space
                    child: Text(
                      widget.description,
                      style: GoogleFonts.domine(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),

              //last row
              Row(
                children: [
                  Container(
                    width: screenWidth * 0.5,
                    child: Text(
                      "Rs: ${widget.price}",
                      style: GoogleFonts.domine(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                  Container(
                    child: TextButton(
                        onPressed: () async {
                          // Check if the product already exists in the cart
                          bool itemExists = false;
                          for (var item in globals.globalCart) {
                            if (item.title == widget.product) {
                              // If the item exists, increment the quantity
                              item.quantity += 1;
                              itemExists = true;
                              break;
                            }
                          }

                          // If the item does not exist, add it to the cart
                          if (!itemExists) {
                            globals.globalCart.add(CartItem(
                              title: widget.product,
                              quantity: 1,
                              price: widget.price,
                              img: widget.image,
                            ));
                          }

                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.amber.shade400)),
                        child: Text("Add To Cart",
                            style: GoogleFonts.domine(
                                fontSize: 16, color: Colors.black))),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
