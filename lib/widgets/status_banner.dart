import 'package:flutter/material.dart';
import 'package:selller_amigo_app/constants.dart';
import 'package:selller_amigo_app/mainScreens/home_screen.dart';


class StatusBanner extends StatelessWidget
{
  final bool? status;
  final String? orderStatus;

  StatusBanner({this.status, this.orderStatus});

  @override
  Widget build(BuildContext context)
  {
    String? message;
    IconData? iconData;

    status! ? iconData = Icons.done : iconData = Icons.cancel;
    status! ? message = "Successful" : message = "Unsuccessful";

    return Container(
      color: kColorGreen,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            orderStatus == "ended"
                ? "Parcel Delivered $message"
                : "Order Placed $message",
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            width: 5,
          ),
          CircleAvatar(
            radius: 8,
            backgroundColor: Colors.grey,
            child: Center(
              child: Icon(
                iconData,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
