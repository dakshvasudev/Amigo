import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_amigo_app/authScreen/auth_screen.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/getStarted.jpg"),
              fit: BoxFit.cover,
              opacity: 80,
            ),
          ),
        ),
        Positioned(
          left: 45,
          right: 21,
          bottom: 118,
          child:  Text('Flavours of your choice...',style: GoogleFonts.lobster(fontSize: 30,color: Colors.white),),
        ),
        Positioned(
          left: 63,
          bottom: 54,
          right: 63,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.black)),
              ),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AuthScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 9, 14, 9),
              child: Container(
                height: 36,
                child: Center(
                  child: Text(
                    'Get Started',
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

// Container(
// height: MediaQuery.of(context).size.height,
// width: MediaQuery.of(context).size.width,
// decoration: const BoxDecoration(
// image: DecorationImage(
// image: AssetImage("assets/images/getStarted.jpg"),
// fit: BoxFit.cover,
// opacity: 80,
// ),
// ),
// child: Column(
// children: [
// Positioned(
// bottom: 20,
// child: ElevatedButton(
// onPressed: () {
// Navigator.push(context,
// MaterialPageRoute(builder: (context) => AuthScreen()));
// },
// child: Text('Get Started'),
// ),
// )
// ],
// ),
// )
