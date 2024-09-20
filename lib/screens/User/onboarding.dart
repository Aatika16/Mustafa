import 'package:flutter/material.dart';
import 'package:ecommerce_shoppe_app/Widgets/BeigeButton.dart';
import 'package:ecommerce_shoppe_app/screens/User/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Onboarding(),
    title: "ShopPE",
    //color: Colors.amber,
  ));
}

class Onboarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Onboarding();
  }
}

class _Onboarding extends State<Onboarding> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Create AnimationController
    _animationController = AnimationController(
      vsync:
          this, // Pass 'this' since _FifthSplashScreenState mixes in TickerProviderStateMixin
      duration: Duration(seconds: 1),
    );

    // Create a curved animation
    CurvedAnimation curve =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    // Create a Tween to define the begin and end values for the animation
    Tween<Offset> tween = Tween(begin: Offset(1.0, 0.0), end: Offset.zero);

    // Apply the tween and the curved animation to get the final animation
    _slideAnimation = tween.animate(curve);

    // Start the animation after 4 seconds
    Future.delayed(Duration(seconds: 5), () {
      _animationController.forward();
    });
  }

  PageController pagecontroller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: pagecontroller,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("images/background.png"),
                      fit: BoxFit.contain)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: Image.asset(
                      "images/firstscreen.png",
                      fit: BoxFit.contain,
                      height: 350,
                      width: 300,
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        right: 30,
                      ),
                      child: Text(
                        "Get Any Thing Online",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w900),
                      )),
                  Container(
                      margin: EdgeInsets.only(right: 30, left: 10),
                      alignment: Alignment.centerRight,
                      //color: Colors.white,
                      child: Text(
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        "You can buy anything ranging from digital products to hardware in few clicks",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      )),
                  // Container(
                  //     margin: EdgeInsets.only(right: 30),
                  //     alignment: Alignment.centerRight,
                  //     //color: Colors.white,
                  //     child: Text(
                  //       "hardware in few clicks.",
                  //       style: TextStyle(
                  //           fontSize: 15,
                  //           fontWeight: FontWeight.w600,
                  //           color: Colors.grey),
                  //     )),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("images/background.png"),
                      fit: BoxFit.contain)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: Image.asset(
                      "images/secondscreen.png",
                      fit: BoxFit.contain,
                      height: 350,
                      width: 300,
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        right: 30,
                      ),
                      child: Text(
                        "On Time Delievery",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w900),
                      )),
                  Container(
                      margin: EdgeInsets.only(
                        right: 30,
                      ),
                      alignment: Alignment.centerRight,
                      //color: Colors.white,
                      child: Text(
                        "You can track your product with our powerful",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      )),
                  Container(
                      margin: EdgeInsets.only(right: 30),
                      alignment: Alignment.centerRight,
                      //color: Colors.white,
                      child: Text(
                        "tracking servce",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      )),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("images/background.png"),
                      fit: BoxFit.contain)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: Image.asset(
                      "images/thirdscreen.png",
                      fit: BoxFit.contain,
                      height: 350,
                      width: 300,
                    ),
                  ),
                  //--------------------------
                  Container(
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        right: 30,
                      ),
                      child: Text(
                        "Shipping to anywhere",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w900),
                      )),
                  Container(
                      margin: EdgeInsets.only(right: 30, left: 10),
                      alignment: Alignment.centerRight,
                      //color: Colors.white,
                      child: Text(
                        textAlign: TextAlign.right,
                        "We will ship to anywhere in the world, within 30 days 100% money back policy",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      )),

                  Container(
                    margin: EdgeInsets.only(right: 30, top: 15),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    //color: Colors.white,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: BeigeButton(
                        topBottomPadding: 10,
                        leftRightPadding: 20,
                        widget_: Text(
                          "Get Started",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        OntapFunction: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        topBottomMargin: 0,
                        leftRightMargin: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 80,
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                  // pagecontroller.jumpToPage(2);
                },
                child: Text(
                  "Skip",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                )),
            Center(
              child: SmoothPageIndicator(
                controller: pagecontroller,
                count: 3,
                onDotClicked: (index) => pagecontroller.animateToPage(index,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear),
                effect: ScaleEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.amber,
                    strokeWidth: 1,
                    activeStrokeWidth: 2,
                    paintStyle: PaintingStyle.fill,
                    dotWidth: 15,
                    dotHeight: 15,
                    spacing: 15,
                    radius: 3,
                    scale: 2,
                    activePaintStyle: PaintingStyle.fill),
              ),
            ),
            TextButton(
                onPressed: () {
                  pagecontroller.nextPage(
                      duration: Duration(microseconds: 500),
                      curve: Curves.easeInCubic);
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                )),
          ],
        ),
      ),
    );
  }
}
