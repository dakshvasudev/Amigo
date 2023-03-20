import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_amigo_app/assistantMethods/assistant_methods.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/models/sellers.dart';
import 'package:user_amigo_app/widgets/FloatingShoppingCart.dart';
import 'package:user_amigo_app/widgets/sellers_design.dart';
import 'package:user_amigo_app/widgets/my_drawer.dart';
import 'package:user_amigo_app/widgets/progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:user_amigo_app/widgets/searchBox.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  Sellers? model;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final items = [
  //   "assets/slider/0.jpg",
  //   "assets/slider/1.jpg",
  //   "assets/slider/2.jpg",
  //   "assets/slider/3.jpg",
  //   "assets/slider/4.jpg",
  //   "assets/slider/5.jpg",
  //   "assets/slider/6.jpg",
  //   "assets/slider/7.jpg",
  //   "assets/slider/8.jpg",
  //   "assets/slider/9.jpg",
  //   "assets/slider/10.jpg",
  //   "assets/slider/11.jpg",
  //   "assets/slider/12.jpg",
  //   "assets/slider/13.jpg",
  //   "assets/slider/14.jpg",
  //   "assets/slider/15.jpg",
  //   "assets/slider/16.jpg",
  //   "assets/slider/17.jpg",
  //   "assets/slider/18.jpg",
  //   "assets/slider/19.jpg",
  //   "assets/slider/20.jpg",
  //   "assets/slider/21.jpg",
  //   "assets/slider/22.jpg",
  //   "assets/slider/23.jpg",
  //   "assets/slider/24.jpg",
  //   "assets/slider/25.jpg",
  //   "assets/slider/26.jpg",
  //   "assets/slider/27.jpg",
  // ];
  void initState() {
    super.initState();

    clearCartNow(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: kColorGreen),
      ),
      drawer: const MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10, left: 75 * 0.36, bottom: 10),
              child: Text(
                'What would you \n like to Eat?',
                style: GoogleFonts.lobster(
                    fontWeight: FontWeight.w400, fontSize: 30),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SearchBox(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 75 * 0.36, bottom: 10),
              child: Text(
                'Restaurants',
                style: GoogleFonts.lemon(
                  fontSize: 21,
                  fontWeight: FontWeight.w400,
                  color: kColorGreen,
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("sellers").snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: circularProgress(),
                      ),
                    )
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 2,
                      staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        Sellers sModel = Sellers.fromJson(
                            snapshot.data!.docs[index].data()!
                                as Map<String, dynamic>);
                        //design for display sellers-cafes-restuarents
                        return SellerDesignWidget(
                          model: sModel,
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
