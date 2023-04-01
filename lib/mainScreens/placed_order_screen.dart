import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_amigo_app/assistantMethods/assistant_methods.dart';
import 'package:user_amigo_app/constants.dart';

import 'home_screen.dart';

class PlacedOrderScreen extends StatefulWidget {
  double? totalAmount;
  String? sellerUID;

  PlacedOrderScreen({super.key, this.sellerUID, this.totalAmount});

  @override
  _PlacedOrderScreenState createState() => _PlacedOrderScreenState();
}

class _PlacedOrderScreenState extends State<PlacedOrderScreen> {
  String orderId = DateTime.now().millisecondsSinceEpoch.toString();

  addOrderDetails() {
    writeOrderDetailsForUser({
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIDs": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Cash on Delivery",
      "orderTime": orderId,
      "isSuccess": true,
      "sellerUID": widget.sellerUID,
      "status": "normal",
      "orderId": orderId,
    });

    writeOrderDetailsForSeller({
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIDs": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Cash on Delivery",
      "orderTime": orderId,
      "isSuccess": true,
      "sellerUID": widget.sellerUID,
      "status": "normal",
      "orderId": orderId,
    }).whenComplete(() {
      clearCartNow(context);
      setState(() {
        orderId = "";
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        Fluttertoast.showToast(
            msg: "Congratulations, Order has been placed successfully.");
      });
    });
  }

  Future writeOrderDetailsForUser(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(orderId)
        .set(data);
  }

  Future writeOrderDetailsForSeller(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set(data);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.cyan,
            Colors.amber,
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/delivery.jpg"),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
              ),
              onPressed: () {
                addOrderDetails();
              },
              child: const Text("Place Order"),
            ),
          ],
        ),
      ),
    );
  }
}
