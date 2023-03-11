import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:selller_amigo_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selller_amigo_app/model/menus.dart';
import 'package:selller_amigo_app/uploadScreen/upload_screen.dart';
import 'package:selller_amigo_app/widgets/info_design.dart';
import 'package:selller_amigo_app/widgets/my_drawer.dart';
import 'package:selller_amigo_app/widgets/progress_bar.dart';
import 'package:selller_amigo_app/widgets/searchBox.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: kColorGreen),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MenuUploadScreen()));
              },
              icon: const Icon(Icons.post_add_rounded))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // SliverPersistentHeader(
          //     pinned: true, delegate: TextWidgetHeader(title: "My Menus")),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10, left: 75 * 0.36),
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
                      staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        Menus model = Menus.fromJson(
                          snapshot.data!.docs[index].data()!
                              as Map<String, dynamic>,
                        );
                        return InfoDesignWidget(
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
