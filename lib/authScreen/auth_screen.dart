import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selller_amigo_app/authScreen/login.dart';
import 'package:selller_amigo_app/authScreen/register.dart';
import 'package:selller_amigo_app/constants.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       automaticallyImplyLeading: false,
    //       backgroundColor: kColorYellow,
    //       scrolledUnderElevation: 15,
    //       shadowColor: kColorYellow,
    //       shape: const RoundedRectangleBorder(
    //         borderRadius: BorderRadius.vertical(
    //           bottom: Radius.circular(55),
    //         ),
    //       ),
    //       title: Center(
    //         child: Text(
    //           'Amigo',
    //           style: GoogleFonts.workSans(
    //             textStyle: TextStyle(
    //               fontWeight: FontWeight.w700,
    //               fontSize: 32,
    //               color: kColorRed,
    //             ),
    //           ),
    //         ),
    //       ),
    //       bottom: TabBar(
    //         tabs: [
    //           Tab(
    //             icon: Icon(
    //               Icons.lock,
    //               color: kColorRed,
    //             ),
    //             text: 'Login',
    //           ),
    //           Tab(
    //             icon: Icon(
    //               Icons.person,
    //               color: kColorRed,
    //             ),
    //             text: 'Register',
    //           ),
    //         ],
    //         indicatorColor: kColorRed,
    //         indicatorWeight: 5,
    //         indicatorSize: TabBarIndicatorSize.label,
    //       ),
    //     ),
    //     body: const TabBarView(
    //       children: [
    //         PhoneNumber(),
    //         RegisterScreen(),
    //       ],
    //     ),
    //   ),
    // );
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
            tabs: [
              Tab(
                icon: Icon(
                  Icons.lock,
                  color: kColorGreen,
                  size: 35,
                ),
                text: 'Login',
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  color: kColorGreen,
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
