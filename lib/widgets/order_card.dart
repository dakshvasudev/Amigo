import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_amigo_app/mainScreens/order_details_screen.dart';
import 'package:user_amigo_app/model/items.dart';

import '../constants.dart';

class OrderCard extends StatelessWidget {
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? seperateQuantitiesList;

  OrderCard({
    this.itemCount,
    this.data,
    this.orderID,
    this.seperateQuantitiesList,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => OrderDetailsScreen(orderID: orderID)));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black)),
        height: itemCount! * 145,
        child: ListView.builder(
          itemCount: itemCount,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Items model =
                Items.fromJson(data![index].data()! as Map<String, dynamic>);
            return placedOrderDesignWidget(
                model, context, seperateQuantitiesList![index]);
          },
        ),
      ),
    );
  }
}

Widget placedOrderDesignWidget(
    Items model, BuildContext context, seperateQuantitiesList) {
  return Padding(
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
                model.thumbnailUrl!,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
//title
                  Text(
                    model.title!,
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
                  Row(
                    children: [
                      Text(
                        "x ",
                        style: GoogleFonts.kaiseiOpti(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        seperateQuantitiesList,
                        style: GoogleFonts.kaiseiOpti(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
//price
                  Expanded(
                    flex: 4,
                    child: Row(
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
                        Text(model.price.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: kColorGreen,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
