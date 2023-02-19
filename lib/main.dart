import 'package:flutter/material.dart';
import 'package:selller_amigo_app/VerificationScreen/verification_screen.dart';
import 'package:selller_amigo_app/phoneNumberScreen/phone_number_screen.dart';
import 'package:selller_amigo_app/splashScreen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


Map<int, Color> color = {
  50: const Color.fromRGBO(136, 14, 79, .1),
  100: const Color.fromRGBO(136, 14, 79, .2),
  200: const Color.fromRGBO(136, 14, 79, .3),
  300: const Color.fromRGBO(136, 14, 79, .4),
  400: const Color.fromRGBO(136, 14, 79, .5),
  500: const Color.fromRGBO(136, 14, 79, .6),
  600: const Color.fromRGBO(136, 14, 79, .7),
  700: const Color.fromRGBO(136, 14, 79, .8),
  800: const Color.fromRGBO(136, 14, 79, .9),
  900: const Color.fromRGBO(136, 14, 79, 1),
};


class MyApp extends StatelessWidget {
  MaterialColor colorCustom = MaterialColor(0xffcf2c4e, color);
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seller app',
      theme: ThemeData(
        primarySwatch: colorCustom,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const VerificationScreen(),
    );
  }
}