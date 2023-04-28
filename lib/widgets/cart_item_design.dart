import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/model/items.dart';

class CartItemDesign extends StatefulWidget {
  final Items? model;
  BuildContext? context;
  final int? quanNumber;

  CartItemDesign({super.key,
    this.model,
    this.context,
    this.quanNumber,
  });

  @override
  _CartItemDesignState createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.cyan,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 75 * 0.36, right: 75 * 0.36, top: 10, bottom: 5),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xffd9d9d9),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 20,
                color: const Color(0xffd9d9d9).withOpacity(0.32),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    widget.model!.thumbnailUrl!,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //title
                      Text(
                        widget.model!.title!,
                        style: GoogleFonts.kaiseiOpti(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      //quantity number // x 7
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            Text(
                              "x ",
                              style: GoogleFonts.kaiseiOpti(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              widget.quanNumber.toString(),
                              style: GoogleFonts.kaiseiOpti(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //price
                      Row(
                        children: [
                          const Text(
                            "Price: ",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "₹̐ ",
                            style: TextStyle(color: kColorGreen, fontSize: 16.0),
                          ),
                          Text(widget.model!.price.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: kColorGreen,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
