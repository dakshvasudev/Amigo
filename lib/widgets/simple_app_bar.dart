import 'package:flutter/material.dart';
import 'package:web_panel_amigo/constants.dart';
import 'package:web_panel_amigo/main_screens/home_screen.dart';


class SimpleAppBar extends StatelessWidget with PreferredSizeWidget
{
  String? title;
  final PreferredSizeWidget? bottom;

  SimpleAppBar({this.bottom, this.title});

  @override
  Size get preferredSize => bottom==null?Size(56, AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context)
  {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      flexibleSpace: Container(
        color: kColorGreen,
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white,),
        onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
        },
      ),
      centerTitle: true,
      title: Text(
        title!,
        style: const TextStyle(fontSize: 20.0, letterSpacing: 3, color: Colors.white,),
      ),
    );
  }
}
