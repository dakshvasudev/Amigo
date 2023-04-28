import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selller_amigo_app/constants.dart';
import 'package:selller_amigo_app/model/items.dart';
import 'package:selller_amigo_app/model/menus.dart';
import 'package:selller_amigo_app/uploadScreen/items_upload_screen.dart';
import 'package:selller_amigo_app/widgets/items_design.dart';
import 'package:selller_amigo_app/widgets/my_drawer.dart';
import 'package:selller_amigo_app/widgets/progress_bar.dart';
import 'package:selller_amigo_app/widgets/searchBox.dart';

class ItemsScreen extends StatefulWidget {
  final Menus? model;
  ItemsScreen({this.model});

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: kColorGreen),
        actions: [
          IconButton(
            icon: const Icon(Icons.library_add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => ItemsUploadScreen(model: widget.model)));
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          // SliverPersistentHeader(
          //     pinned: true,
          //     delegate: TextWidgetHeader(
          //         title:
          //             "My " + widget.model!.menuTitle.toString() + "'s Items")),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 75 * 0.36),
              child: Text(
                sharedPreferences!.getString('name')!,
                style: GoogleFonts.lobster(
                  fontWeight: FontWeight.w400,
                  fontSize: 34,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10, left: 75 * 0.36, bottom: 10),
              child: Text(
                'Serving the best..',
                style: GoogleFonts.lobster(
                    color: kColorGreen,
                    fontWeight: FontWeight.w400,
                    fontSize: 24),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SearchBox(),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(sharedPreferences!.getString("uid"))
                .collection("menus")
                .doc(widget.model!.menuID)
                .collection("items")
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
                        Items model = Items.fromJson(
                          snapshot.data!.docs[index].data()!
                              as Map<String, dynamic>,
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
    );
  }
}