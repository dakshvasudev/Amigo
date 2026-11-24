import 'package:flutter/material.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/mainScreens/menus_screen.dart';
import 'package:user_amigo_app/models/sellers.dart';

/// One stall in the "On campus now" list.
class SellerDesignWidget extends StatelessWidget {
  final Sellers? model;
  final BuildContext? context;

  const SellerDesignWidget({Key? key, this.model, this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final seller = model!;
    final avatar = seller.sellerAvatarUrl;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: kColorBorder),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => MenusScreen(model: seller)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 52,
                    height: 52,
                    color: kColorRed.withOpacity(0.1),
                    child: avatar == null || avatar.isEmpty
                        ? const Icon(Icons.storefront, color: kColorRed)
                        : Image.network(avatar, fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.storefront, color: kColorRed)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        seller.sellerName ?? 'Stall',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: kColorInk),
                      ),
                      const SizedBox(height: 2),
                      const Text('Tap to see the menu',
                          style: TextStyle(fontSize: 12, color: kColorMuted)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Color(0xffa1a1aa)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
