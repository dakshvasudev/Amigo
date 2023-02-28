import 'package:flutter/material.dart';
import 'package:selller_amigo_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selller_amigo_app/uploadScreen/upload_screen.dart';
import 'package:selller_amigo_app/widgets/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: kColorYellow,
        scrolledUnderElevation: 15,
        shadowColor: kColorYellow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Center(
          child: Text(
            sharedPreferences!.getString('name')!,
            style: GoogleFonts.workSans(
              textStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 32,
                color: kColorRed,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>MenuUploadScreen()));}, icon: Icon(Icons.post_add_rounded))
        ],
      ),
      body: const Center(),
    );
  }
}
