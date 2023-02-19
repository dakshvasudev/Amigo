import 'package:flutter/material.dart';
import 'constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorRed,
      body: Center(
        child: Image.asset(
          "assets/images/LatestIcon.png",
          width: 700.0,
          height: 300.0,
        ),
      ),
    );
  }
}
