import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_amigo_app/assistantMethods/order_service.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/mainScreens/order_details_screen.dart';
import 'package:user_amigo_app/model/order_status.dart';
import 'package:user_amigo_app/widgets/amigo_ui.dart';

/// itemID -> quantity from an order's productIDs ("itemID:qty" strings).
Map<String, int> orderQuantities(dynamic productIDs) {
  final result = <String, int>{};
  if (productIDs is! List) return result;
  for (final raw in productIDs) {
    final entry = raw.toString();
    final pos = entry.lastIndexOf(':');
    if (pos == -1) continue;
    final qty = int.tryParse(entry.substring(pos + 1)) ?? 0;
    if (qty > 0) result[entry.substring(0, pos)] = qty;
  }
  return result;
}

/// Seller name for an order, loaded once.
class SellerName extends StatelessWidget {
  final String? sellerUID;
  final TextStyle style;
  const SellerName({Key? key, required this.sellerUID, required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sellerUID == null) return Text('Order', style: style);
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('sellers').doc(sellerUID).get(),
      builder: (context, s) {
        final data = s.data?.data() as Map<String, dynamic>?;
        return Text((data?['sellerName'] as String?) ?? 'Order', style: style);
      },
    );
  }
}

/// "1× Cheese Maggi, 2× Latte" for an order.
class OrderItemsSummary extends StatelessWidget {
  final Map<String, int> quantities;
  const OrderItemsSummary({Key? key, required this.quantities}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (quantities.isEmpty) return const SizedBox.shrink();
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('items')
          .where('itemID', whereIn: quantities.keys.take(10).toList())
          .get(),
      builder: (context, s) {
        if (!s.hasData) {
          return const Text('…', style: TextStyle(fontSize: 12, color: kColorMuted));
        }
        final names = <String, String>{};
        for (final d in s.data!.docs) {
          final m = d.data()! as Map<String, dynamic>;
          final id = m['itemID'] as String?;
          if (id != null) names[id] = (m['title'] as String?) ?? 'Item';
        }
        final text = quantities.entries
            .where((e) => names.containsKey(e.key))
            .map((e) => '${e.value}× ${names[e.key]}')
            .join(', ');
        return Text(text, style: const TextStyle(fontSize: 12, color: kColorMuted));
      },
    );
  }
}

/// Vertical tracker: placed → being prepared → ready for pickup → collected.
class OrderTracker extends StatelessWidget {
  final OrderStage stage;
  const OrderTracker({Key? key, required this.stage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final current = trackedStages.indexOf(stage);
    return Column(
      children: List.generate(trackedStages.length, (i) {
        final done = i <= current;
        final isCurrent = i == current && stage != OrderStage.collected;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: done ? kColorRed : Colors.white,
                  border: Border.all(color: done ? kColorRed : const Color(0xffd4d4d8)),
                  boxShadow: isCurrent
                      ? [BoxShadow(color: kColorRed.withOpacity(0.18), spreadRadius: 4)]
                      : null,
                ),
                child: done ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
              ),
              const SizedBox(width: 10),
              Text(
                stageLabel(trackedStages[i]),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: done ? FontWeight.w500 : FontWeight.w400,
                  color: done ? kColorInk : const Color(0xffa1a1aa),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

/// Five tappable stars, saved to the order.
class RatingRow extends StatelessWidget {
  final String orderID;
  final int? rating;
  const RatingRow({Key? key, required this.orderID, this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: kColorSurface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(rating != null ? 'Thanks for rating!' : 'How was it?',
                style: const TextStyle(fontSize: 12, color: kColorMuted)),
          ),
          ...List.generate(5, (i) {
            final n = i + 1;
            final filled = rating != null && n <= rating!;
            return InkResponse(
              onTap: () => rateOrder(orderID, n),
              radius: 16,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Icon(
                  filled ? Icons.star_rounded : Icons.star_outline_rounded,
                  size: 22,
                  color: filled ? kColorStar : const Color(0xffd4d4d8),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class PickupCodeChip extends StatelessWidget {
  final String orderID;
  const PickupCodeChip({Key? key, required this.orderID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: kColorInk,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        pickupCode(orderID),
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderID;
  final Map<String, dynamic> data;

  const OrderCard({Key? key, required this.orderID, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stage = stageFromStatus(data['status'] as String?);
    final rating = (data['rating'] as num?)?.toInt();
    final total = (data['totalAmount'] as num?) ?? 0;

    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: kColorBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (c) => OrderDetailsScreen(orderID: orderID)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SellerName(
                          sellerUID: data['sellerUID'] as String?,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: kColorInk),
                        ),
                        const SizedBox(height: 2),
                        OrderItemsSummary(quantities: orderQuantities(data['productIDs'])),
                        const SizedBox(height: 2),
                        Text(rupees(total),
                            style: const TextStyle(fontSize: 12, color: kColorMuted)),
                      ],
                    ),
                  ),
                  PickupCodeChip(orderID: orderID),
                ],
              ),
              const SizedBox(height: 12),
              if (stage == OrderStage.rejected)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xfffef2f2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "The stall couldn't take this order. Nothing to pay.",
                    style: TextStyle(fontSize: 12, color: Color(0xffb91c1c)),
                  ),
                )
              else
                OrderTracker(stage: stage),
              if (stage == OrderStage.placed) ...[
                const SizedBox(height: 8),
                const Text('Waiting for the stall to accept your order.',
                    style: TextStyle(fontSize: 12, color: kColorMuted)),
              ],
              if (stage == OrderStage.ready) ...[
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kColorYellow.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Show code ${pickupCode(orderID)} at the counter.',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600, color: kColorInk),
                  ),
                ),
              ],
              if (stage == OrderStage.collected) ...[
                const SizedBox(height: 10),
                RatingRow(orderID: orderID, rating: rating),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
