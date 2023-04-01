import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_panel_amigo/constants.dart';
import 'package:web_panel_amigo/main_screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String adminEmail = "";
  String password = "";

  allowAdminToLogin() async {
    final snackBar = SnackBar(
      content: Text(
        'Checking credentials, Please wait...',
        style: GoogleFonts.poppins(fontSize: 36),
      ),
      backgroundColor: Colors.grey,
      duration: const Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    User? currentAdmin;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: adminEmail, password: password)
        .then((fAuth) {
      currentAdmin = fAuth.user;
    }).catchError((onError) {
      final snackBar = SnackBar(
        content: Text(
          'Error Occured:' + onError.toString(),
          style: GoogleFonts.poppins(fontSize: 36),
        ),
        backgroundColor: Colors.grey,
        duration: const Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    if (currentAdmin != null) {
      await FirebaseFirestore.instance
          .collection("admins")
          .doc(currentAdmin!.uid)
          .get()
          .then((snap) {
        if (snap.exists) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          final snackBar = SnackBar(
            content: Text(
              'NO RECORD FOUND,PLEASE CONTACT THE DEVELOPER TO BE AN ADMIN OF THE APP',
              style: GoogleFonts.poppins(fontSize: 36),
            ),
            backgroundColor: Colors.grey,
            duration: const Duration(seconds: 5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                Image.asset('images/admin.png'),
                Material(
                  child: TextField(
                    onChanged: (value) {
                      adminEmail = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kColorGreen, width: 2)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2)),
                      hintText: 'E-mail',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Material(
                  child: TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kColorGreen, width: 2)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2)),
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    obscuringCharacter: '*',
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    allowAdminToLogin();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 65,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(7)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
                          style: GoogleFonts.ibmPlexSans(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
