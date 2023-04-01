import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/get_started_screen.dart';
import 'package:user_amigo_app/mainScreens/home_screen.dart';
import 'package:user_amigo_app/mainScreens/my_orders_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffd9d9d9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(53), bottomRight: Radius.circular(53)),
      ),
      child: ListView(
        children: [
          //header drawer
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: SizedBox(
                      height: 130,
                      width: 130,
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
                Text(sharedPreferences!.getString("name")!,
                    style: GoogleFonts.kaiseiOpti(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20)),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 26, right: 26),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    size: 30,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Home",
                    style: GoogleFonts.kaiseiOpti(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
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
                    Icons.reorder,
                    size: 30,
                    color: Colors.black,
                  ),
                  title: Text(
                    "My Orders",
                    style: GoogleFonts.kaiseiOpti(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyOrdersScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.access_time,
                    size: 30,
                    color: Colors.black,
                  ),
                  title: Text(
                    "History",
                    style: GoogleFonts.kaiseiOpti(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  onTap: () {},
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    size: 30,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Sign Out",
                    style: GoogleFonts.kaiseiOpti(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  onTap: () {
                    firebaseAuth.signOut().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const GetStartedScreen()));
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
          ),
        ],
      ),
    );
  }
}
