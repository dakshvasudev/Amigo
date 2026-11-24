import 'dart:async';
import 'package:flutter/material.dart';
import 'package:user_amigo_app/get_started_screen.dart';
import 'package:user_amigo_app/mainScreens/home_screen.dart';
import 'constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      final Widget next = firebaseAuth.currentUser != null
          ? const HomeScreen()
          : const GetStartedScreen();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => next));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorRed,
      body: Center(
        child: Image.asset('assets/images/Logoamigo.jpeg', width: 280),
      ),
    );
  }
}
