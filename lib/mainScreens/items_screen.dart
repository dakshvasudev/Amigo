import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/model/items.dart';
import 'package:user_amigo_app/model/menus.dart';
import 'package:user_amigo_app/widgets/FloatingShoppingCart.dart';
import 'package:user_amigo_app/widgets/app_bar.dart';
import 'package:user_amigo_app/widgets/items_design.dart';
import 'package:user_amigo_app/widgets/progress_bar.dart';
import 'package:user_amigo_app/widgets/searchBox.dart';



class ItemsScreen extends StatefulWidget
{
  final Menus? model;
  ItemsScreen({this.model});

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}



class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 85*0.36,bottom: 10),
              child: Text(
                'Taste of Joy..',
                style: GoogleFonts.lobster(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 32,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 85*0.36),
              child: Text(
                'Select your favourites...',
                style: GoogleFonts.lobsterTwo(
                    color: kColorGreen,
                    fontWeight: FontWeight.w400,
                    fontSize: 24),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SearchBox(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 85*0.36),
              child: Text(
                 'Items of '+widget.model!.menuTitle.toString(),
                style: GoogleFonts.lemon(
                  color: kColorGreen,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(widget.model!.sellerUID)
                .collection("menus")
                .doc(widget.model!.menuID)
                .collection("items")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                child: Center(child: circularProgress(),),
              )
                  : SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                itemBuilder: (context, index)
                {
                  Items model = Items.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  );
                  return ItemsDesignWidget(
                    model: model,
                    context: context,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingShoppingCart(),
    );
  }
}
