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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.33,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: kColorYellow,
                      border: Border.all(
                        color: kColorYellow,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      widget.model!.sellerAvatarUrl!,
                      height: 220.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                Positioned(
                  bottom: -0.5,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                        color: kColorRed,
                        border: Border.all(
                          color: kColorRed,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            widget.model!.sellerName!,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.model!.sellerEmail!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
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
