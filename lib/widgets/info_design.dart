import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selller_amigo_app/constants.dart';
import 'package:selller_amigo_app/mainScreens/itemsScreen.dart';
import 'package:selller_amigo_app/model/menus.dart';

class InfoDesignWidget extends StatefulWidget {
  final Menus? model;
  BuildContext? context;

  InfoDesignWidget({super.key, this.model, this.context});

  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: kColorGreen,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemsScreen(model: widget.model)));
        },
        // child: Container(
        //   height: 210,
        //   width: 90,
        //   margin:
        //       const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        //   decoration: BoxDecoration(
        //     color: Colors.blue,
        //     borderRadius: BorderRadius.circular(10),
        //     boxShadow: [
        //       BoxShadow(
        //         offset: const Offset(0, 4),
        //         blurRadius: 20,
        //         color: kColorRed.withOpacity(0.32),
        //       ),
        //     ],
        //   ),
        //   child: Material(
        //     color: Colors.transparent,
        //     child: InkWell(
        //       onTap: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) =>
        //                     ItemsScreen(model: widget.model)));
        //       },
        //       child: Padding(
        //         padding: const EdgeInsets.all(20.0),
        //         child: Column(
        //           children: <Widget>[
        //             CircleAvatar(
        //               radius: 65,
        //               backgroundImage: NetworkImage(
        //                 widget.model!.thumbnailUrl!,
        //               ),
        //             ),
        //             const SizedBox(
        //               height: 10,
        //             ),
        //             Text(
        //               widget.model!.menuTitle!,
        //               style: const TextStyle(
        //                   color: Colors.white,
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 20),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // )
      child: Padding(
        padding: const EdgeInsets.only(left: 75 * 0.36,bottom: 20,right: 75 * 0.36),
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
          height: MediaQuery.of(context).size.height * 0.16,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffd9d9d9),
                  border: Border.all(color: const Color(0xffd9d9d9)),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.cover,
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
