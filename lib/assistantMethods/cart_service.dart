import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:user_amigo_app/assistantMethods/cart_Item_counter.dart';
import 'package:user_amigo_app/constants.dart';

// The cart keeps the original storage format so existing users keep their
// carts: a string list in SharedPreferences and in users/{uid}.userCart,
// starting with the 'garbageValue' sentinel, then "itemID:quantity" entries.
// The seller the cart belongs to is stored alongside it, one stall per order.

const String _sentinel = 'garbageValue';
const String _cartKey = 'userCart';
const String _cartSellerKey = 'cartSellerUID';

/// itemID -> quantity, in the order items were added.
Map<String, int> readCart() {
  final raw = sharedPreferences!.getStringList(_cartKey) ?? [_sentinel];
  final cart = <String, int>{};
  for (final entry in raw) {
    if (entry == _sentinel) continue;
    final pos = entry.lastIndexOf(':');
    if (pos == -1) continue;
    final qty = int.tryParse(entry.substring(pos + 1)) ?? 0;
    if (qty > 0) cart[entry.substring(0, pos)] = qty;
  }
  return cart;
}

String? cartSellerUID() {
  final uid = sharedPreferences!.getString(_cartSellerKey);
  return (uid == null || uid.isEmpty) ? null : uid;
}

int cartQuantityOf(String? itemID) => itemID == null ? 0 : (readCart()[itemID] ?? 0);

Future<void> _writeCart(BuildContext context, Map<String, int> cart,
    {String? sellerUID}) async {
  final list = <String>[_sentinel];
  cart.forEach((id, qty) {
    if (qty > 0) list.add('$id:$qty');
  });

  await sharedPreferences!.setStringList(_cartKey, list);
  await sharedPreferences!
      .setString(_cartSellerKey, list.length == 1 ? '' : (sellerUID ?? ''));

  Provider.of<CartItemCounter>(context, listen: false)
      .displayCartListItemsNumber();

  final user = firebaseAuth.currentUser;
  if (user != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({_cartKey: list});
  }
}

/// Sets the quantity of one item. Adding from a different stall starts a new cart.
Future<void> setCartQuantity(
  BuildContext context, {
  required String itemID,
  required String sellerUID,
  required int quantity,
}) async {
  var cart = readCart();
  final currentSeller = cartSellerUID();
  if (quantity > 0 && currentSeller != null && currentSeller != sellerUID) {
    cart = {};
    Fluttertoast.showToast(msg: 'Started a new cart, one stall per order.');
  }
  if (quantity <= 0) {
    cart.remove(itemID);
  } else {
    cart[itemID] = quantity;
  }
  await _writeCart(context, cart, sellerUID: sellerUID);
}

Future<void> emptyCart(BuildContext context) => _writeCart(context, {});
