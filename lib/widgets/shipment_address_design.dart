import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:selller_amigo_app/constants.dart';


class ShipmentAddressDesign extends StatefulWidget {
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderByUser;
  ShipmentAddressDesign(
      {this.orderStatus,
      required this.orderId,
      this.sellerId,
      this.orderByUser});

  @override
  State<ShipmentAddressDesign> createState() => _ShipmentAddressDesignState();
}

class _ShipmentAddressDesignState extends State<ShipmentAddressDesign> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Status of order:',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 6.0,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: () {
                setState(() {
                  FirebaseFirestore.instance
                      .collection("orders")
                      .doc(widget.orderId)
                      .update({'status': 'ended'});
                });
              },
              child: Container(
                color: kColorGreen,
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: Center(
                  child: Text(
                    widget.orderStatus == "ended"
                        ? "Order Delivered"
                        : "Order Packing - Done",
                    style: const TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
