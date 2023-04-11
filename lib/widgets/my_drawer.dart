import 'package:flutter/material.dart';
import 'package:selller_amigo_app/authScreen/auth_screen.dart';
import 'package:selller_amigo_app/constants.dart';
import 'package:selller_amigo_app/mainScreens/earnings_screen.dart';
import 'package:selller_amigo_app/mainScreens/history_screen.dart';
import 'package:selller_amigo_app/mainScreens/home_screen.dart';
import 'package:selller_amigo_app/mainScreens/new_orders_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(120), bottomRight: Radius.circular(40)),
      ),
      child: ListView(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        children: [
          //header drawer
          Container(
            padding: const EdgeInsets.only(top: 105, bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            sharedPreferences!.getString("photoUrl")!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 20, fontFamily: "Train"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title: const Text(
                  "Home",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
              const Divider(
                height: 10,
                color: Colors.grey,
                thickness: 2,
              ),
              ListTile(
                leading: const Icon(
                  Icons.attach_money,
                  color: Colors.black,
                ),
                title: const Text(
                  "My Earnings",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EarningsScreen()));
                },
              ),
              const Divider(
                height: 10,
                color: Colors.grey,
                thickness: 2,
              ),
              ListTile(
                leading: const Icon(
                  Icons.fastfood_outlined,
                  color: Colors.black,
                ),
                title: const Text(
                  "New Orders",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewOrdersScreen()));
                },
              ),
              const Divider(
                height: 10,
                color: Colors.grey,
                thickness: 2,
              ),
              ListTile(
                leading: const Icon(
                  Icons.local_shipping,
                  color: Colors.black,
                ),
                title: const Text(
                  "History of orders",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryScreen()));
                },
              ),
              const Divider(
                height: 10,
                color: Colors.grey,
                thickness: 2,
              ),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
                title: const Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  firebaseAuth.signOut().then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const AuthScreen()));
                  });
                },
              ),
              const Divider(
                height: 10,
                color: Colors.grey,
                thickness: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
