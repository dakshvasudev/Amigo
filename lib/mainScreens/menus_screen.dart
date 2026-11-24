import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_amigo_app/assistantMethods/cart_Item_counter.dart';
import 'package:user_amigo_app/assistantMethods/cart_service.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/mainScreens/home_screen.dart';
import 'package:user_amigo_app/mainScreens/item_detail_screen.dart';
import 'package:user_amigo_app/model/items.dart';
import 'package:user_amigo_app/model/menus.dart';
import 'package:user_amigo_app/models/sellers.dart';
import 'package:user_amigo_app/widgets/amigo_ui.dart';
import 'package:user_amigo_app/widgets/progress_bar.dart';

/// A stall's full menu: every menu becomes a section, with its items inline.
class MenusScreen extends StatelessWidget {
  final Sellers? model;
  const MenusScreen({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final seller = model!;
    return Scaffold(
      body: Column(
        children: [
          AmigoHeader(
            title: seller.sellerName ?? 'Menu',
            onBack: () => Navigator.pop(context),
          ),
          Consumer<CartItemCounter>(
            builder: (context, _, __) {
              final other = cartSellerUID();
              if (other == null || other == seller.sellerUID) {
                return const SizedBox.shrink();
              }
              return Container(
                width: double.infinity,
                color: kColorYellow.withOpacity(0.4),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: const Text(
                  'Adding here starts a new cart (one stall per order).',
                  style: TextStyle(fontSize: 12, color: kColorInk),
                ),
              );
            },
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sellers')
                  .doc(seller.sellerUID)
                  .collection('menus')
                  .orderBy('publishedDate', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return circularProgress();
                final menus = snapshot.data!.docs
                    .map((d) => Menus.fromJson(d.data()! as Map<String, dynamic>))
                    .toList();
                if (menus.isEmpty) {
                  return const EmptyState(
                      icon: Icons.restaurant_menu,
                      message: 'This stall has not added a menu yet.');
                }
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  itemCount: menus.length,
                  itemBuilder: (context, i) => _MenuSection(menu: menus[i]),
                );
              },
            ),
          ),
          _ViewCartBar(sellerUID: seller.sellerUID),
        ],
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  final Menus menu;
  const _MenuSection({required this.menu});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        SectionLabel(menu.menuTitle ?? 'Menu'),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('sellers')
              .doc(menu.sellerUID)
              .collection('menus')
              .doc(menu.menuID)
              .collection('items')
              .orderBy('publishedDate', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: LinearProgressIndicator(minHeight: 2),
              );
            }
            final items = snapshot.data!.docs
                .map((d) => Items.fromJson(d.data()! as Map<String, dynamic>))
                .toList();
            return Column(children: items.map((it) => ItemRow(item: it)).toList());
          },
        ),
      ],
    );
  }
}

bool isSoldOut(Items item) {
  final s = (item.status ?? '').toLowerCase();
  return s == 'sold out' || s == 'soldout' || s == 'unavailable';
}

/// One menu item with its ADD / stepper control.
class ItemRow extends StatelessWidget {
  final Items item;
  const ItemRow({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final soldOut = isSoldOut(item);
    final thumb = item.thumbnailUrl;
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (c) => ItemDetailsScreen(model: item)),
      ),
      child: Opacity(
        opacity: soldOut ? 0.45 : 1,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xfff4f4f5))),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: thumb == null || thumb.isEmpty
                      ? Container(color: kColorSurface)
                      : Image.network(thumb, fit: BoxFit.cover,
                          errorBuilder: (c, e, s) =>
                              Container(color: kColorSurface)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title ?? '',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: kColorInk)),
                    if ((item.shortInfo ?? '').isNotEmpty)
                      Text(item.shortInfo!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12, color: kColorMuted)),
                    Text(rupees(item.price ?? 0),
                        style: const TextStyle(fontSize: 12, color: kColorMuted)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              soldOut
                  ? const Text('Sold out',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: kColorMuted))
                  : Consumer<CartItemCounter>(
                      builder: (context, _, __) {
                        final qty = cartSellerUID() == item.sellerUID
                            ? cartQuantityOf(item.itemID)
                            : 0;
                        return QtyStepper(
                          qty: qty,
                          onAdd: () => setCartQuantity(context,
                              itemID: item.itemID!,
                              sellerUID: item.sellerUID!,
                              quantity: qty + 1),
                          onRemove: () => setCartQuantity(context,
                              itemID: item.itemID!,
                              sellerUID: item.sellerUID!,
                              quantity: qty - 1),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ViewCartBar extends StatelessWidget {
  final String? sellerUID;
  const _ViewCartBar({required this.sellerUID});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartItemCounter>(
      builder: (context, counter, _) {
        if (counter.count <= 0 || cartSellerUID() != sellerUID) {
          return const SizedBox.shrink();
        }
        final units = readCart().values.fold<int>(0, (a, b) => a + b);
        return Container(
          padding: EdgeInsets.fromLTRB(
              16, 10, 16, 10 + MediaQuery.of(context).padding.bottom),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: kColorBorder)),
          ),
          child: PrimaryButton(
            label: 'View cart · $units item${units == 1 ? '' : 's'}',
            onPressed: () => HomeScreen.open(context, tab: 2),
          ),
        );
      },
    );
  }
}
