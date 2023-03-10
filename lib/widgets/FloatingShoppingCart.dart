import 'package:flutter/material.dart';
import 'package:user_amigo_app/constants.dart';

class FloatingShoppingCart extends StatelessWidget {
  const FloatingShoppingCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      isExtended: true,
      elevation: 10,
      backgroundColor: kColorGreen,
      onPressed: () {},
      child: const Icon(
        Icons.shopping_cart,
        color: Colors.black,
      ),
    );
  }
}