import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/model/items.dart';
import 'package:user_amigo_app/widgets/app_bar.dart';
import 'package:user_amigo_app/assistantMethods/assistant_methods.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Items? model;
  ItemDetailsScreen({this.model});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  TextEditingController counterTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.model!.title.toString(),
                // 'Description',
                style: GoogleFonts.kaiseiOpti(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffd9d9d9),
                    border: Border.all(color: const Color(0xffd9d9d9)),
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.model!.thumbnailUrl!,
                      ),
                    ),
                  ),
                  height: 135,
                  width: 238,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: NumberInputPrefabbed.roundedButtons(
                  controller: counterTextEditingController,
                  incDecBgColor: kColorGreen,
                  incIcon: Icons.add_circle,
                  incIconColor: Colors.black,
                  decIcon: Icons.remove_circle,
                  decIconColor: Colors.black,
                  min: 1,
                  max: 15,
                  initialValue: 1,
                  buttonArrangement: ButtonArrangement.incRightDecLeft,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  // widget.model!.title.toString(),
                  'Description',
                  style: GoogleFonts.kaiseiOpti(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffd9d9d9),
                    border: Border.all(color: const Color(0xffd9d9d9)),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffd9d9d9),
                        spreadRadius: 2,
                        // blurRadius: 1,
                        offset: Offset(1, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.model!.longDescription.toString(),
                    textAlign: TextAlign.justify,
                    style:
                        const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Price: ₹ '+ widget.model!.price.toString(),
                  style: GoogleFonts.kaiseiOpti(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    int itemCounter = int.parse(counterTextEditingController.text);
                    //1.check if item exist already in cart
                    // separateItemIDsList.contains(widget.model!.itemID)
                    //     ? Fluttertoast.showToast(msg: "Item is already in Cart.")
                    //     :
                    //2.add to cart
                    addItemToCart(widget.model!.itemID, context, itemCounter);
                  },
                  child: Container(
                    color: kColorGreen,
                    width: MediaQuery.of(context).size.width - 13,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Add to Cart",
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
