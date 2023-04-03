import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/orderplaced.png",
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            onPressed: () {
              addOrderDetails();
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                ),
                height: 42,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Center(
                    child: Text(
                  "Place Order",
                  style: GoogleFonts.ibmPlexSans(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ))),
          ),
        ],
      ),
    );
  }
}
