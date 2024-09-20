import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/Widgets/userDrawer.dart';
import 'package:ecommerce_shoppe_app/screens/User/Dashboard.dart';
import 'package:ecommerce_shoppe_app/screens/User/cart.dart';
import 'package:ecommerce_shoppe_app/screens/User/contactUs.dart';
import 'package:ecommerce_shoppe_app/screens/User/editProfile.dart';
import 'package:ecommerce_shoppe_app/screens/User/login.dart';
import 'package:ecommerce_shoppe_app/screens/User/productsScreen.dart';
import 'package:ecommerce_shoppe_app/screens/User/review.dart';
import 'package:ecommerce_shoppe_app/screens/User/searchScreen.dart';

class BN extends StatefulWidget {
  final String name;
  final String email;
  final String Userid;
  final String contact;
  const BN(
      {Key? key,
      required this.name,
      required this.email,
      required this.Userid,
      required this.contact})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BN();
  }
}

class _BN extends State<BN> {
  List<Widget> pages = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    getEmail_via_Sp();
    getName_via_Sp();

    // Initialize pages
    pages = [
      Dashboard(
        name: widget.name,
        email: widget.email,
        Userid: widget.Userid,
        contact: widget.contact,
      ),
      SearchScreen(
        name: widget.name,
        email: widget.email,
        Userid: widget.Userid,
        contact: widget.contact,
      ),
      CartScreen(
        name: widget.name,
        email: widget.email,
        Userid: widget.Userid,
        contact: widget.contact,
      ),
      EditProfile(
        name: widget.name,
        email: widget.email,
        Userid: widget.Userid,
        contact: widget.contact,
      ),
    ];
  }

  void _navigateToAdminDashboard(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BN(
                name: name.toString(),
                email: email.toString(),
                Userid: widget.Userid,
                contact: widget.contact)));
  }

  void _navigateToCartFetch(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CartScreen(
                name: name.toString(),
                email: email.toString(),
                Userid: widget.Userid,
                contact: widget.contact)));
  }

  void _navigateToProductsFetch(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductsScreen(
                name: name.toString(),
                email: email.toString(),
                Userid: widget.Userid,
                contact: widget.contact)));
  }

  void _navigateToSearchAdd(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchScreen(
                name: name.toString(),
                email: email.toString(),
                Userid: widget.Userid,
                contact: widget.contact)));
  }

  void _navigateToReviewFetch(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReviewScreen(
                name: name.toString(),
                email: email.toString(),
                Userid: widget.Userid,
                contact: widget.contact)));
  }

  void _navigateToContactFetch(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactUsScreen(
                name: name.toString(),
                email: email.toString(),
                Userid: widget.Userid,
                contact: widget.contact)));
  }

  void _navigateToUserDetails(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfile(
                name: name.toString(),
                email: email.toString(),
                Userid: widget.Userid,
                contact: widget.contact)));
  }

  void _navigateToLoginDetails(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void logout() async {
    SharedPreferences sp_logout = await SharedPreferences.getInstance();
    sp_logout.remove("sp_email");
    sp_logout.remove("sp_name");
    _navigateToLoginDetails(BuildContext context) {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
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

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                        builder: (context) => SearchScreen(
                            name: widget.name,
                            email: widget.email,
                            Userid: widget.Userid,
                            contact: widget.contact)));
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
      drawer: Drawer(
        backgroundColor: Color.fromRGBO(255, 202, 40, 0.7),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/onboardbg.png"),
                    fit: BoxFit.fitWidth),
                color: Colors.amber.shade400,
              ),
              child: Center(
                child: Text(
                  "Shop Pe",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.domine(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                      decorationStyle: TextDecorationStyle.solid,
                      fontSize: 27),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: screenheight * 0.8,
                child: ListView(padding: EdgeInsets.all(10), children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.amber.shade400,
                          child: ClipOval(
                            child: Icon(Icons.home, color: Colors.black),

                            //Image.asset("images/profile1.png"),
                          ),
                        ),
                        title: Text(
                          "Home",
                          style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                        trailing: Icon(
                          Icons.keyboard_double_arrow_right_rounded,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Navigator.pop(context); // Close the drawer
                          _navigateToAdminDashboard(context);
                        },
                        tileColor: Color.fromRGBO(255, 255, 255, 1),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.elliptical(10, 10),
                            ),
                            side: BorderSide(
                                color: Colors.amber.shade400,
                                width: 0.5,
                                strokeAlign: BorderSide.strokeAlignCenter)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.amber.shade400,
                          child: ClipOval(
                            child: Icon(Icons.add_shopping_cart_sharp,
                                color: Colors.black),

                            //Image.asset("images/profile1.png"),
                          ),
                        ),
                        title: Text(
                          "Products",
                          style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                        trailing: Icon(
                          Icons.keyboard_double_arrow_right_rounded,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Navigator.pop(context); // Close the drawer
                          _navigateToProductsFetch(context);
                        },
                        tileColor: Color.fromRGBO(255, 255, 255, 1),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.elliptical(10, 10),
                            ),
                            side: BorderSide(
                                color: Colors.amber.shade400,
                                width: 0.5,
                                strokeAlign: BorderSide.strokeAlignCenter)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.amber.shade400,
                          child: ClipOval(
                            child: Icon(Icons.reviews_rounded,
                                color: Colors.black),

                            //Image.asset("images/profile1.png"),
                          ),
                        ),
                        title: Text(
                          "Add Review",
                          style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                        trailing: Icon(
                          Icons.keyboard_double_arrow_right_rounded,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Navigator.pop(context); // Close the drawer
                          _navigateToReviewFetch(context);
                        },
                        tileColor: Color.fromRGBO(255, 255, 255, 1),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.elliptical(10, 10),
                            ),
                            side: BorderSide(
                                color: Colors.amber.shade400,
                                width: 0.5,
                                strokeAlign: BorderSide.strokeAlignCenter)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.amber.shade400,
                          child: ClipOval(
                            child: Icon(Icons.contact_support_sharp,
                                color: Colors.black),

                            //Image.asset("images/profile1.png"),
                          ),
                        ),
                        title: Text(
                          "Contact Us",
                          style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                        trailing: Icon(
                          Icons.keyboard_double_arrow_right_rounded,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Navigator.pop(context); // Close the drawer
                          _navigateToContactFetch(context);
                        },
                        tileColor: Color.fromRGBO(255, 255, 255, 1),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.elliptical(10, 10),
                            ),
                            side: BorderSide(
                                color: Colors.amber.shade400,
                                width: 0.5,
                                strokeAlign: BorderSide.strokeAlignCenter)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.amber.shade400,
                          child: ClipOval(
                            child: Icon(Icons.power_settings_new_rounded,
                                color: Colors.black),

                            //Image.asset("images/profile1.png"),
                          ),
                        ),
                        title: Text(
                          "Logout",
                          style: GoogleFonts.domine(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                        trailing: Icon(
                          Icons.keyboard_double_arrow_left_rounded,
                          color: Colors.black,
                        ),
                        onTap: () {
                          logout();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        tileColor: Color.fromRGBO(255, 255, 255, 1),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.elliptical(10, 10),
                            ),
                            side: BorderSide(
                                color: Colors.amber.shade400,
                                width: 0.5,
                                strokeAlign: BorderSide.strokeAlignCenter)),
                      ),
                    ),
                  ),
                ])),
          ],
        ),
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        child: pages[selectedIndex], // Use the list here
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        buttonBackgroundColor: Colors.amber.shade400,
        backgroundColor: Colors.white,
        color: Colors.amber.shade400,
        animationCurve: Curves.easeInQuart,
        animationDuration: Duration(milliseconds: 700),
        items: const <Widget>[
          Icon(
            Icons.home_outlined,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.search,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.shopping_cart_outlined,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.person_3_outlined,
            size: 30,
            color: Colors.black,
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
