import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_amigo_app/assistantMethods/cart_Item_counter.dart';
import 'package:user_amigo_app/assistantMethods/total_amount.dart';
import 'package:user_amigo_app/splashScreen.dart';
import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

Map<int, Color> color = {
  50: const Color.fromRGBO(55, 123, 54, 0.1),
  100: const Color.fromRGBO(55, 123, 54, 0.2),
  200: const Color.fromRGBO(55, 123, 54, 0.3),
  300: const Color.fromRGBO(55, 123, 54, 0.4),
  400: const Color.fromRGBO(55, 123, 54, 0.5),
  500: const Color.fromRGBO(55, 123, 54, 0.6),
  600: const Color.fromRGBO(55, 123, 54, 0.7),
  700: const Color.fromRGBO(55, 123, 54, 0.8),
  800: const Color.fromRGBO(55, 123, 54, 0.9),
  900: const Color.fromRGBO(55, 123, 54, 1),
};

class MyApp extends StatelessWidget {
  MaterialColor colorCustom = MaterialColor(0xff377b36, color);
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ChangeNotifierProvider(create: (c) => TotalAmount()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Users app',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: colorCustom)
              .copyWith(secondary: kColorGreen),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
