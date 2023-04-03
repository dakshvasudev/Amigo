import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selller_amigo_app/constants.dart';


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
      elevation: 0,
      iconTheme:  IconThemeData(
        color: kColorGreen,
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        title!,
        style: GoogleFonts.ibmPlexMono(fontSize: 24,fontWeight: FontWeight.w600,color: kColorGreen),
      ),
    );
  }
}
