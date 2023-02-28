import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selller_amigo_app/constants.dart';

class MenuUploadScreen extends StatefulWidget {
  const MenuUploadScreen({Key? key}) : super(key: key);

  @override
  State<MenuUploadScreen> createState() => _MenuUploadScreenState();
}

class _MenuUploadScreenState extends State<MenuUploadScreen> {
  @override

  defaultScreen(){
    return Scaffold(
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
            'Add New Menu',
            style: GoogleFonts.workSans(
              textStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 26,
                color: kColorRed,
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.menu_book,size: 180,),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: (){}, child: Text('Add New Menu')),
          ],
        ),
      ),
    );
  }
  Widget build(BuildContext context) {
    return defaultScreen();
  }
}
