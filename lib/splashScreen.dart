import 'dart:async';

import 'package:flutter/material.dart';
import 'package:user_amigo_app/authScreen/auth_screen.dart';
import 'package:user_amigo_app/mainScreens/home_screen.dart';

import 'constants.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTimer(){
    Timer(const Duration(seconds: 3), () async {
      if(firebaseAuth.currentUser != null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=>  HomeScreen()));
      }
      //if seller is NOT logged in already
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
      }
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
