import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_shoppe_app/screens/User/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBT9omXRkOitOMKPIVMAU8ynahdr9VQHXU",
          appId: "1:926393960566:android:9e72f9ff7b8484b0e73757",
          messagingSenderId: "926393960566",
          storageBucket: "shoppe-ecommerce.appspot.com",
          projectId: "shoppe-ecommerce"));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        title: "Shop Pe");
  }
}
