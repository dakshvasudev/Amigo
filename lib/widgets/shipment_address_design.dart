import 'package:flutter/material.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/splashScreen.dart';

class ShipmentAddressDesign extends StatelessWidget {
  final String orderStatus;
   ShipmentAddressDesign({super.key,required this.orderStatus});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Order Status',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 6.0,
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SplashScreen()));
              },
              child: Container(
                color: kColorGreen,
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: Center(
                  child: Text(
                    orderStatus == "ended" ? "Go Back" : "Order Packing - Done",
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
