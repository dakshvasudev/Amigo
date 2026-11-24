import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_amigo_app/assistantMethods/cart_Item_counter.dart';
import 'package:user_amigo_app/assistantMethods/total_amount.dart';
import 'package:user_amigo_app/splashScreen.dart';
import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences!.getStringList('userCart') == null) {
    await sharedPreferences!.setStringList('userCart', ['garbageValue']);
  }
  runApp(const MyApp());
}

const Map<int, Color> _redShades = {
  50: Color.fromRGBO(207, 44, 78, 0.1),
  100: Color.fromRGBO(207, 44, 78, 0.2),
  200: Color.fromRGBO(207, 44, 78, 0.3),
  300: Color.fromRGBO(207, 44, 78, 0.4),
  400: Color.fromRGBO(207, 44, 78, 0.5),
  500: Color.fromRGBO(207, 44, 78, 0.6),
  600: Color.fromRGBO(207, 44, 78, 0.7),
  700: Color.fromRGBO(207, 44, 78, 0.8),
  800: Color.fromRGBO(207, 44, 78, 0.9),
  900: Color.fromRGBO(207, 44, 78, 1),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const swatch = MaterialColor(0xffcf2c4e, _redShades);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ChangeNotifierProvider(create: (c) => TotalAmount()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Amigo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: swatch)
              .copyWith(secondary: kColorYellow),
          textTheme: GoogleFonts.interTextTheme(),
          splashColor: kColorRed.withOpacity(0.08),
          highlightColor: kColorRed.withOpacity(0.04),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
