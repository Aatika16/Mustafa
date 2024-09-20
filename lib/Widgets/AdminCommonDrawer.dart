import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/OrdersFetch.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/adminDashboard.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/contactFetch.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/productsAdd.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/productsFetch.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/reviewFetch.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/userDetails.dart';
import 'package:ecommerce_shoppe_app/screens/User/login.dart';

class CommonDrawer extends StatelessWidget {
  final String name;
  final String email;
  final String Userid;
  final String contact;
  final String address;
  const CommonDrawer(
      {Key? key,
      required this.name,
      required this.email,
      required this.Userid,
      required this.contact,
      required this.address})
      : super(key: key);

  void _navigateToAdminDashboard(BuildContext context) {
    Navigator.pop(context); // Close the drawer before navigating
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdminDashboard(
                name: name, email: email, Userid: Userid, contact: contact, address: address,)));
  }

  void _navigateToContactFetch(BuildContext context) {
    Navigator.pop(context); // Close the drawer before navigating
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactFetch(
                name: name, email: email, Userid: Userid, contact: contact,address: address,)));
  }

  void _navigateToOrdersFetch(BuildContext context) {
    Navigator.pop(context); // Close the drawer before navigating
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OrdersFetch(
                name: name, email: email, Userid: Userid, contact: contact, address: address,)));
  }

  void _navigateToProductsAdd(BuildContext context) {
    Navigator.pop(context); // Close the drawer before navigating
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductsAdd(
                name: name, email: email, Userid: Userid, contact: contact, address: address,)));
  }

  void _navigateToProductsFetch(BuildContext context) {
    Navigator.pop(context); // Close the drawer before navigating
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductsFetch(
                name: name, email: email, Userid: Userid, contact: contact,address: address,)));
  }

  void _navigateToReviewFetch(BuildContext context) {
    Navigator.pop(context); // Close the drawer before navigating
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReviewFetch(
                name: name, email: email, Userid: Userid, contact: contact,address: address,)));
  }

  void _navigateToUserDetails(BuildContext context) {
    Navigator.pop(context); // Close the drawer before navigating
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserDetails(
                name: name, email: email, Userid: Userid, contact: contact,address: address,)));
  }

  void logout() async {
    SharedPreferences sp_logout = await SharedPreferences.getInstance();
    sp_logout.remove("sp_email");
    sp_logout.remove("sp_name");
    __navigateToLogout(BuildContext context) {
      Navigator.pop(context); // Close the drawer before navigating
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
                        "Dashboard",
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
                          child: Icon(Icons.contact_page, color: Colors.black),

                          //Image.asset("images/profile1.png"),
                        ),
                      ),
                      title: Text(
                        "Contacts",
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
                          child: Icon(Icons.add_shopping_cart_outlined,
                              color: Colors.black),

                          //Image.asset("images/profile1.png"),
                        ),
                      ),
                      title: Text(
                        "Orders",
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
                        _navigateToOrdersFetch(context);
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
                          child: Icon(Icons.add_to_photos, color: Colors.black),

                          //Image.asset("images/profile1.png"),
                        ),
                      ),
                      title: Text(
                        "Add Products",
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
                        _navigateToProductsAdd(context);
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
                          child: Icon(Icons.production_quantity_limits_sharp,
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
                          child: Icon(Icons.reviews, color: Colors.black),

                          //Image.asset("images/profile1.png"),
                        ),
                      ),
                      title: Text(
                        "Reviews",
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
                          child:
                              Icon(Icons.account_circle, color: Colors.black),

                          //Image.asset("images/profile1.png"),
                        ),
                      ),
                      title: Text(
                        "Users",
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
                        _navigateToUserDetails(context);
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
                          child: Icon(Icons.power_settings_new_outlined,
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
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
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
          // ListTile(
          //   leading: Icon(
          //     Icons.home,
          //     color: Colors.white,
          //   ),
          //   title: const Text(
          //     'Dashboard',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onTap: () {
          //     Navigator.pop(context); // Close the drawer
          //     _navigateToAdminDashboard(context);
          //   },
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.contact_page,
          //     color: Colors.white,
          //   ),
          //   title: const Text(
          //     'Contacts',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onTap: () {

          //   },
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.add_shopping_cart_sharp,
          //     color: Colors.white,
          //   ),
          //   title: const Text(
          //     'Orders',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onTap: () {

          //   },
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.add_to_photos,
          //     color: Colors.white,
          //   ),
          //   title: const Text(
          //     'Add Products',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onTap: () {

          //   },
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.production_quantity_limits_sharp,
          //     color: Colors.white,
          //   ),
          //   title: const Text(
          //     'Products',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onTap: () {},
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.reviews,
          //     color: Colors.white,
          //   ),
          //   title: const Text(
          //     'Reviews',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onTap: () {

          //   },
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.account_circle,
          //     color: Colors.white,
          //   ),
          //   title: const Text(
          //     'Users',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onTap: () {
          //     Navigator.pop(context); // Close the drawer
          //     _navigateToUserDetails(context);
          //   },
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.arrow_back,
          //     color: Colors.white,
          //   ),
          //   title: const Text(
          //     'Logout',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onTap: () {
          //     Navigator.pop(context); // Close the drawer
          //     _navigateToLogout(context);
          //   },
          // ),
        ],
      ),
    );
  }
}
