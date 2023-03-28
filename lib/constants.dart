import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color kColorYellow = const Color(0xffffda2a);
Color kColorRed = const Color(0xffcf2c4e);
Color kColorGreen = const Color(0xff377b36);
const kPrimaryColor = Color(0xFFFFC61F);
const kSecondaryColor = Color(0xFFB5BFD0);
const kTextColor = Color(0xFF50505D);
const kTextLightColor = Color(0xFF6A727D);

SharedPreferences? sharedPreferences;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
