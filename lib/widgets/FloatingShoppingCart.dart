import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_amigo_app/assistantMethods/cart_Item_counter.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/mainScreens/cart_screen.dart';

class FloatingShoppingCart extends StatelessWidget {
  final String? sellerUID;
   const FloatingShoppingCart({
    Key? key, this.sellerUID
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      isExtended: true,
      elevation: 10,
      backgroundColor: kColorGreen,
      onPressed: () {},
      child: Stack(
        children: [
          IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen(sellerUID: sellerUID,)));
              }),
          Positioned(
            right: 2,
            child: Stack(
              children: [
                const Icon(
                  Icons.brightness_1,
                  size: 20.0,
                  color: Colors.red,
                ),
                Positioned(
                  top: 3,
                  right: 5,
                  child: Center(
                    child: Consumer<CartItemCounter>(
                      builder: (context, counter, c) {
                        return Text(
                          counter.count.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
