import 'package:flutter/material.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 120,
          automaticallyImplyLeading: false,
          backgroundColor: kColorRed,
          elevation: 0,
          title: Center(
            child: Image.asset('assets/images/Logoamigo.jpeg', height: 110),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            tabs: const [
              Tab(icon: Icon(Icons.lock_outline), text: 'Login'),
              Tab(icon: Icon(Icons.person_outline), text: 'Register'),
            ],
            indicatorColor: kColorYellow,
            indicatorWeight: 4,
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
