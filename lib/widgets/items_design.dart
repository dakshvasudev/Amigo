import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/mainScreens/item_detail_screen.dart';
import 'package:user_amigo_app/model/items.dart';

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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ItemDetailsScreen(model: widget.model)));
      },
      splashColor: kColorGreen,
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
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.model!.thumbnailUrl!,
                    ),
                  ),
                ),
                height: 100,
                width: 100,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model!.title!,
                    style: GoogleFonts.kaiseiOpti(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.model!.shortInfo!,
                    style: GoogleFonts.kaiseiOpti(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '₹ ${widget.model!.price!}',
                    style: GoogleFonts.kaiseiOpti(
                      color: Colors.black,
                      fontSize: 18,
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
