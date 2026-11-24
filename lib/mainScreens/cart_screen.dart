import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:user_amigo_app/assistantMethods/cart_Item_counter.dart';
import 'package:user_amigo_app/assistantMethods/cart_service.dart';
import 'package:user_amigo_app/assistantMethods/order_service.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/mainScreens/home_screen.dart';
import 'package:user_amigo_app/model/items.dart';
import 'package:user_amigo_app/widgets/amigo_ui.dart';
import 'package:user_amigo_app/widgets/progress_bar.dart';

class CartScreen extends StatelessWidget {
  /// Kept for older call sites; the cart now remembers its own stall.
  final String? sellerUID;
  final VoidCallback? onBrowse;
  final VoidCallback? onOrderPlaced;

  const CartScreen({Key? key, this.sellerUID, this.onBrowse, this.onOrderPlaced})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final standalone = onBrowse == null;
    return Scaffold(
      body: Column(
        children: [
          AmigoHeader(
            title: 'Cart',
            onBack: standalone ? () => Navigator.pop(context) : null,
          ),
          Expanded(
            child: Consumer<CartItemCounter>(
              builder: (context, _, __) {
                final cart = readCart();
                final seller = cartSellerUID() ?? sellerUID;
                if (cart.isEmpty || seller == null) {
                  return EmptyState(
                    icon: Icons.shopping_bag_outlined,
                    message: 'Your cart is empty.',
                    actionLabel: 'Browse stalls',
                    onAction: onBrowse ?? () => HomeScreen.open(context),
                  );
                }
                return _CartBody(
                  cart: cart,
                  sellerUID: seller,
                  onOrderPlaced: onOrderPlaced ?? () => HomeScreen.open(context, tab: 1),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CartBody extends StatefulWidget {
  final Map<String, int> cart;
  final String sellerUID;
  final VoidCallback onOrderPlaced;

  const _CartBody({
    required this.cart,
    required this.sellerUID,
    required this.onOrderPlaced,
  });

  @override
  State<_CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<_CartBody> {
  bool _placing = false;

  Future<void> _place(num total) async {
    setState(() => _placing = true);
    try {
      await placeOrder(sellerUID: widget.sellerUID, totalAmount: total);
      if (!mounted) return;
      await emptyCart(context);
      Fluttertoast.showToast(msg: 'Order placed. We will tell you when it is ready.');
      widget.onOrderPlaced();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Could not place the order. Please try again.');
      if (mounted) setState(() => _placing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ids = widget.cart.keys.toList();
    return StreamBuilder<QuerySnapshot>(
      // Firestore allows up to 10 values in a whereIn query
      stream: FirebaseFirestore.instance
          .collection('items')
          .where('itemID', whereIn: ids.take(10).toList())
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return circularProgress();
        final byId = <String, Items>{};
        for (final d in snapshot.data!.docs) {
          final it = Items.fromJson(d.data()! as Map<String, dynamic>);
          if (it.itemID != null) byId[it.itemID!] = it;
        }
        final lines = ids.where(byId.containsKey).toList();
        final total = lines.fold<num>(
            0, (sum, id) => sum + (byId[id]!.price ?? 0) * widget.cart[id]!);

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('sellers')
                        .doc(widget.sellerUID)
                        .get(),
                    builder: (context, s) {
                      final data = s.data?.data() as Map<String, dynamic>?;
                      return Text(
                        (data?['sellerName'] as String?) ?? 'Your order',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: kColorInk),
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                  ...lines.map((id) {
                    final it = byId[id]!;
                    final qty = widget.cart[id]!;
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Color(0xfff4f4f5))),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(it.title ?? '',
                                style: const TextStyle(fontSize: 14, color: kColorInk)),
                          ),
                          QtyStepper(
                            qty: qty,
                            onAdd: () => setCartQuantity(context,
                                itemID: id, sellerUID: widget.sellerUID, quantity: qty + 1),
                            onRemove: () => setCartQuantity(context,
                                itemID: id, sellerUID: widget.sellerUID, quantity: qty - 1),
                          ),
                          SizedBox(
                            width: 64,
                            child: Text(rupees((it.price ?? 0) * qty),
                                textAlign: TextAlign.right,
                                style: const TextStyle(fontSize: 14, color: kColorInk)),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  _TotalRow(label: 'Subtotal', value: rupees(total)),
                  const SizedBox(height: 6),
                  _TotalRow(label: 'To pay', value: rupees(total), bold: true),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: _placing ? null : () => emptyCart(context),
                      style: TextButton.styleFrom(
                          foregroundColor: kColorMuted, padding: EdgeInsets.zero),
                      child: const Text('Clear cart'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: kColorBorder)),
              ),
              child: Column(
                children: [
                  PrimaryButton(
                    label: 'Place order · ${rupees(total)}',
                    loading: _placing,
                    onPressed: lines.isEmpty ? null : () => _place(total),
                  ),
                  const SizedBox(height: 6),
                  const Text('Pay at the counter when you pick up',
                      style: TextStyle(fontSize: 11, color: Color(0xffa1a1aa))),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  const _TotalRow({required this.label, required this.value, this.bold = false});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: bold ? 15 : 13,
      fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
      color: bold ? kColorInk : kColorMuted,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label, style: style), Text(value, style: style)],
    );
  }
}
