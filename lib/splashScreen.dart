import 'dart:async';
import 'package:selller_amigo_app/authScreen/auth_screen.dart';
import 'package:selller_amigo_app/authScreen/login.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTimer(){
    Timer(const Duration(seconds: 3), () async {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AuthScreen()));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
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