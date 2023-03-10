import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/mainScreens/items_screen.dart';
import 'package:user_amigo_app/model/menus.dart';

class MenusDesignWidget extends StatefulWidget {
  Menus? model;
  BuildContext? context;

  MenusDesignWidget({this.model, this.context});

  @override
  _MenusDesignWidgetState createState() => _MenusDesignWidgetState();
}

class _MenusDesignWidgetState extends State<MenusDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemsScreen(model: widget.model)));
      },
      splashColor: kColorGreen,
      child: Padding(
        padding: const EdgeInsets.all(75 * 0.36),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffd9d9d9),
            border: Border.all(color: const Color(0xffd9d9d9)),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffd9d9d9),
                spreadRadius: 2,
                // blurRadius: 1,
                offset: Offset(1, 0), // changes position of shadow
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.15,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffd9d9d9),
                  border: Border.all(color: const Color(0xffd9d9d9)),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      widget.model!.thumbnailUrl!,
                    ),
                  ),
                ),
                height: 90,
                width: 90,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.model!.menuTitle!,
                style: GoogleFonts.kaiseiOpti(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
