import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selller_amigo_app/constants.dart';
import 'package:selller_amigo_app/model/items.dart';

class ItemsDesignWidget extends StatefulWidget {
  Items? model;
  BuildContext? context;

  ItemsDesignWidget({this.model, this.context});

  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
      },
      splashColor: kColorGreen,
      // child: Padding(
      //     padding: const EdgeInsets.all(5.0),
      //     child: Container(
      //       height: 210,
      //       width: 90,
      //       margin:
      //           const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      //       decoration: BoxDecoration(
      //         color: kColorRed,
      //         borderRadius: BorderRadius.circular(10),
      //         boxShadow: [
      //           BoxShadow(
      //             offset: const Offset(0, 4),
      //             blurRadius: 20,
      //             color: kColorRed.withOpacity(0.32),
      //           ),
      //         ],
      //       ),
      //       child: Material(
      //         color: Colors.transparent,
      //         child: InkWell(
      //           onTap: () {
      //             // Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemsScreen(model: widget.model)));
      //           },
      //           child: Padding(
      //             padding: const EdgeInsets.all(20.0),
      //             child: Column(
      //               children: <Widget>[
      //                 CircleAvatar(
      //                   radius: 65,
      //                   backgroundImage: NetworkImage(
      //                     widget.model!.thumbnailUrl!,
      //                   ),
      //                 ),
      //                 const SizedBox(
      //                   height: 10,
      //                 ),
      //                 Text(
      //                   widget.model!.title!,
      //                   style: const TextStyle(
      //                       color: Colors.white,
      //                       fontWeight: FontWeight.bold,
      //                       fontSize: 20),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     )),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
          height: MediaQuery.of(context).size.height * 0.18,
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
                height: 100,
                width: 100,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model!.title!,
                    style: GoogleFonts.kaiseiOpti(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.model!.shortInfo!,
                    style: GoogleFonts.kaiseiOpti(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '₹ ' + widget.model!.price!.toString(),
                    style: GoogleFonts.kaiseiOpti(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
