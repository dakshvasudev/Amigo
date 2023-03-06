import 'package:flutter/material.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/models/sellers.dart';

class InfoDesignWidget extends StatefulWidget {
  Sellers? model;
  BuildContext? context;

  InfoDesignWidget({this.model, this.context});

  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.amber,
        child: Container(
          height: 210,
          width: 90,
          margin:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: kColorRed,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 20,
                color: kColorRed.withOpacity(0.32),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 65,
                      backgroundImage: NetworkImage(
                        widget.model!.sellerAvatarUrl!,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.model!.sellerName!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
// Padding(
// padding: const EdgeInsets.all(5.0),
// child: SizedBox(
// height: 280,
// width: MediaQuery.of(context).size.width,
// child: Column(
// children: [
// Divider(
// height: 4,
// thickness: 3,
// color: Colors.grey[300],
// ),
// Image.network(
// widget.model!.sellerAvatarUrl!,
// height: 220.0,
// fit: BoxFit.cover,
// ),
// const SizedBox(height: 1.0,),
// Text(
// widget.model!.sellerName!,
// style: const TextStyle(
// color: Colors.cyan,
// fontSize: 20,
// ),
// ),
// Text(
// widget.model!.sellerEmail!,
// style: const TextStyle(
// color: Colors.grey,
// fontSize: 12,
// ),
// ),
// Divider(
// height: 4,
// thickness: 3,
// color: Colors.grey[300],
// ),
// ],
// ),
// ),
// ),
