import 'package:flutter/material.dart';
import 'package:selller_amigo_app/constants.dart';
import 'package:selller_amigo_app/splashScreen.dart';

class ShipmentAddressDesign extends StatelessWidget {
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderByUser;

  const ShipmentAddressDesign(
      {super.key, this.orderStatus, this.orderId, this.sellerId, this.orderByUser});

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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashScreen()));
              },
              child: Container(
                color: kColorGreen,
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: Center(
                  child: Text(
                    orderStatus == "ended" ? "Go Back" : "Order Packing - Done",
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
