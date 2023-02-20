import 'package:flutter/material.dart';
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kColorYellow,
          scrolledUnderElevation: 15,
          shadowColor: kColorYellow,
          title: Text(
            'Amigo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: kColorRed,
            ),
            textAlign: TextAlign.end,
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.lock,
                  color: kColorRed,
                ),
                text: 'Login',
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  color: kColorRed,
                ),
                text: 'Register',
              ),
            ],
            indicatorColor: kColorRed,
            indicatorWeight: 5,
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
