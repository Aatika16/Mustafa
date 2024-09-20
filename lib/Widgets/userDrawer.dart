import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/Widgets/bottomnavigation.dart';
import 'package:ecommerce_shoppe_app/screens/User/Dashboard.dart';
import 'package:ecommerce_shoppe_app/screens/User/cart.dart';
import 'package:ecommerce_shoppe_app/screens/User/contactUs.dart';
import 'package:ecommerce_shoppe_app/screens/User/editProfile.dart';
import 'package:ecommerce_shoppe_app/screens/User/login.dart';
import 'package:ecommerce_shoppe_app/screens/User/productsScreen.dart';
import 'package:ecommerce_shoppe_app/screens/User/review.dart';
import 'package:ecommerce_shoppe_app/screens/User/searchScreen.dart';

String? useremail;
String? username;

class UserCommonDrawer extends StatelessWidget {
  final String name;
  final String email;
  final String Userid;
  final String contact;
  const UserCommonDrawer(
      {Key? key,
      required this.name,
      required this.email,
      required this.Userid,
      required this.contact})
      : super(key: key);

  void _navigateToAdminDashboard(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BN(
                name: name, email: email, Userid: Userid, contact: contact)));
  }

  void _navigateToCartFetch(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CartScreen(
                name: name, email: email, Userid: Userid, contact: contact)));
  }

  void _navigateToProductsFetch(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductsScreen(
                name: name, email: email, Userid: Userid, contact: contact)));
  }

  void _navigateToSearchAdd(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchScreen(
                name: name, email: email, Userid: Userid, contact: contact)));
  }

  void _navigateToReviewFetch(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReviewScreen(
                name: name, email: email, Userid: Userid, contact: contact)));
  }

  void _navigateToContactFetch(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactUsScreen(
                name: name, email: email, Userid: Userid, contact: contact)));
  }

  void _navigateToUserDetails(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfile(
                email: email, contact: contact, name: name, Userid: Userid)));
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

  @override
  Widget build(BuildContext context) {
    
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Drawer(
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
      );
  }
}
