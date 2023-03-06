import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_amigo_app/authScreen/login.dart';
import 'package:user_amigo_app/authScreen/register.dart';
import 'package:user_amigo_app/constants.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xffd9d9d9),
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.2,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 15,
          // shadowColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(45),
            ),
          ),
          title: const Center(
            child: Text(
              '',
            ),
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            labelStyle: GoogleFonts.ibmPlexSans(),
            tabs: const [
              Tab(
                icon: Icon(
                  Icons.lock,
                  color: Colors.black,
                  size: 35,
                ),
                text: 'Login',
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 35,
                ),
                text: 'Register',
              ),
            ],
            indicatorColor: kColorGreen,
            indicatorWeight: 7,
            indicatorSize: TabBarIndicatorSize.label,
          ),
        ),
        body: const TabBarView(
          children: [
            PhoneNumber(),
            RegisterScreen(),
          ],
        ),
      ),
    );
  }
}
