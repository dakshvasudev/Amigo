import 'package:flutter/material.dart';
import 'package:selller_amigo_app/authScreen/auth_screen.dart';
import 'package:selller_amigo_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kColorYellow,
      scrolledUnderElevation: 15,
      shadowColor: kColorYellow,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      title: Center(
        child: Text(
          sharedPreferences!.getString('name')!,
          style: GoogleFonts.workSans(
            textStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 32,
              color: kColorRed,
            ),
          ),
        ),
      ),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyan,
          ),
          onPressed: ()
          {
            firebaseAuth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
            });
          },
          child: const Text("Logout"),
        ),
      ),
    );
  }
}
