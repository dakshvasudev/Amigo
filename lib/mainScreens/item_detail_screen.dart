import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_amigo_app/assistantMethods/cart_service.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/mainScreens/menus_screen.dart';
import 'package:user_amigo_app/model/items.dart';
import 'package:user_amigo_app/widgets/amigo_ui.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Items? model;
  const ItemDetailsScreen({Key? key, this.model}) : super(key: key);

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  late int _qty;
  bool _saving = false;

  Items get item => widget.model!;

  @override
  void initState() {
    super.initState();
    final inCart =
        cartSellerUID() == item.sellerUID ? cartQuantityOf(item.itemID) : 0;
    _qty = inCart > 0 ? inCart : 1;
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    await setCartQuantity(context,
        itemID: item.itemID!, sellerUID: item.sellerUID!, quantity: _qty);
    if (!mounted) return;
    Fluttertoast.showToast(msg: 'Added to cart.');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final soldOut = isSoldOut(item);
    final thumb = item.thumbnailUrl;
    return Scaffold(
      body: Column(
        children: [
          AmigoHeader(title: item.title ?? '', onBack: () => Navigator.pop(context)),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: thumb == null || thumb.isEmpty
                        ? Container(color: kColorSurface)
                        : Image.network(thumb, fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                Container(color: kColorSurface)),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(item.title ?? '',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: kColorInk)),
                    ),
                    Text(rupees(item.price ?? 0),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: kColorInk)),
                  ],
                ),
                if ((item.shortInfo ?? '').isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(item.shortInfo!,
                      style: const TextStyle(fontSize: 13, color: kColorMuted)),
                ],
                if ((item.longDescription ?? '').isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const SectionLabel('About this item'),
                  const SizedBox(height: 6),
                  Text(item.longDescription!,
                      style: const TextStyle(
                          fontSize: 14, height: 1.5, color: kColorInk)),
                ],
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
                16, 12, 16, 12 + MediaQuery.of(context).padding.bottom),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: kColorBorder)),
            ),
            child: soldOut
                ? const PrimaryButton(label: 'Sold out')
                : Row(
                    children: [
                      QtyStepper(
                        qty: _qty,
                        onAdd: () => setState(() => _qty = _qty < 15 ? _qty + 1 : 15),
                        onRemove: () => setState(() => _qty = _qty > 1 ? _qty - 1 : 1),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: PrimaryButton(
                          label: 'Add · ${rupees((item.price ?? 0) * _qty)}',
                          loading: _saving,
                          onPressed: _save,
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
