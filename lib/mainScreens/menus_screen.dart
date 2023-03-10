import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/model/menus.dart';
import 'package:user_amigo_app/models/sellers.dart';
import 'package:user_amigo_app/widgets/menus_design.dart';
import 'package:user_amigo_app/widgets/progress_bar.dart';
import 'package:user_amigo_app/widgets/searchBox.dart';

class MenusScreen extends StatefulWidget {
  final Sellers? model;
  MenusScreen({this.model});

  @override
  _MenusScreenState createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: kColorGreen),
      ),
      body: CustomScrollView(
        slivers: [
          // SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: widget.model!.sellerName.toString() + " Menus")),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 85*0.36,bottom: 10),
              child: Text(
                widget.model!.sellerName!,
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
                'Sellers favourites...',
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
                'Menu',
                style: GoogleFonts.lemon(
                    color: kColorGreen,
                    fontSize: 24,
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(widget.model!.sellerUID)
                .collection("menus")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: circularProgress(),
                      ),
                    )
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        Menus model = Menus.fromJson(
                          snapshot.data!.docs[index].data()!
                              as Map<String, dynamic>,
                        );
                        return MenusDesignWidget(
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
    );
  }
}
