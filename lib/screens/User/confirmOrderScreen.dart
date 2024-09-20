import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';
import 'package:ecommerce_shoppe_app/Widgets/bottomnavigation.dart';
import 'package:ecommerce_shoppe_app/screens/User/Dashboard.dart';

class ConfirmOrderScreen extends StatefulWidget {
  final String name;
  final String email;
  final String Userid;
  final String contact;
  const ConfirmOrderScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.Userid,
      required this.contact});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.2),
        child: Column(
          children: [
            SizedBox(
              height: 180,
            ),
            Center(
              child: Image.asset("Images/confrimorder.gif",height: 100,width:100,),
            ),
            Text(
              'DONE ORDER',
              style: GoogleFonts.domine(
                  color: Colors.amber.shade400,
                  fontSize: 20,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'THANKS FOR CHOOSING SHOP PE',
              style: GoogleFonts.domine(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'YOUR ORDER HAS BEEN\n   DELIVER IN 7 DAYS',
              style: GoogleFonts.domine(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w700),
            ),
            Spacer(),

            //done button
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BN(
                            name: widget.name,
                            email: widget.email,
                            Userid: widget.Userid,
                            contact: widget.contact)));
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber.shade400,
                  borderRadius:
                      BorderRadius.circular(Constants.buttonBorderRadius),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10), // Adjust the padding as needed
                    child: Text(
                      "Done",
                      style: GoogleFonts.domine(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 22),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
