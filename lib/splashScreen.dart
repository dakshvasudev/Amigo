import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_amigo_app/get_started_screen.dart';
import 'package:user_amigo_app/mainScreens/home_screen.dart';
import 'constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      if (firebaseAuth.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => HomeScreen()));
      }
      //if seller is NOT logged in already
      else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const GetStartedScreen()));
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
      backgroundColor: kColorGreen,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fastfood,color: Colors.white,size: 110,),
            SizedBox(
              height: 15,
            ),
            Text('AMIGO',style: GoogleFonts.francoisOne(fontSize: 55,color: Colors.white),),
          ],
        ),
      )
    );
  }
}
