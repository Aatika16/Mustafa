import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_shoppe_app/Widgets/bottomnavigation.dart';
import 'package:ecommerce_shoppe_app/screens/Admin/adminDashboard.dart';
import 'package:ecommerce_shoppe_app/screens/User/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

String? FinalEmail;
String? FinalName;
String? FinalContact;

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  //--------------------- to check if sharedprefernces available or not
  @override
  void initState() {
    getDataShareDPref().whenComplete(
      () {
        Timer(Duration(seconds: 10), () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => FinalEmail == null
                  ? Onboarding()
                  : BN(
                      name: '',
                      Userid: '',
                      contact: FinalContact.toString(),
                      email: FinalEmail.toString(),
                    )));
        });
        print(FinalEmail);
        print(FinalName);
      },
    );
    super.initState();
  }

  Future getDataShareDPref() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString("sp_email");
    var obtainedname = sharedPreferences.getString("sp_name");
    var obtainedcontact = sharedPreferences.getString("sp_contact");

    setState(() {
      FinalEmail = obtainedEmail;
      FinalName = obtainedname;
      FinalContact = obtainedcontact;
    });
  }

  @override
  Widget build(BuildContext context) {
    // double screenwidth = MediaQuery.of(context).size.width;
    // double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.amber.shade400,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.amber.shade400,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image(
                  image: AssetImage("Images/coupleshopping.png"),
                  fit: BoxFit.fitHeight,
                  opacity: AlwaysStoppedAnimation(0.5),
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white30,
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 400,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 100),
                          child: Image(
                            image: AssetImage("Images/logo.png"),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Container(
                            width: double.infinity,
                            //  padding: EdgeInsets.symmetric(horizontal: 80),
                            child: Text(
                              textAlign: TextAlign.center,
                              "Complete Shopping Solution",
                              style: GoogleFonts.domine(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
