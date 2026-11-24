import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Brand colours, matching the Amigo logo and the web demo
const Color kColorRed = Color(0xffcf2c4e);
const Color kColorRedDark = Color(0xff7a1328);
const Color kColorYellow = Color(0xffffda2a);
const Color kColorStar = Color(0xffffb800);
const Color kColorSuccess = Color(0xff16a34a);
const Color kColorInk = Color(0xff18181b);
const Color kColorMuted = Color(0xff71717a);
const Color kColorBorder = Color(0xffe4e4e7);
const Color kColorSurface = Color(0xfffafafa);

const kPrimaryColor = Color(0xFFFFC61F);
const kSecondaryColor = Color(0xFFB5BFD0);
const kTextColor = Color(0xFF50505D);
const kTextLightColor = Color(0xFF6A727D);

SharedPreferences? sharedPreferences;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
