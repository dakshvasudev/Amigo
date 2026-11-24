import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/model/order_status.dart';
import 'package:user_amigo_app/widgets/amigo_ui.dart';
import 'package:user_amigo_app/widgets/order_card.dart';
import 'package:user_amigo_app/widgets/progress_bar.dart';

const List<String> _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String _formatOrderTime(dynamic orderTime) {
  final ms = int.tryParse(orderTime?.toString() ?? '');
  if (ms == null) return '';
  final d = DateTime.fromMillisecondsSinceEpoch(ms);
  final hour = d.hour % 12 == 0 ? 12 : d.hour % 12;
  final minute = d.minute.toString().padLeft(2, '0');
  final ampm = d.hour < 12 ? 'AM' : 'PM';
  return '${d.day} ${_months[d.month - 1]} ${d.year}, $hour:$minute $ampm';
}

class OrderDetailsScreen extends StatelessWidget {
  final String? orderID;
  const OrderDetailsScreen({Key? key, this.orderID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = sharedPreferences!.getString('uid') ?? firebaseAuth.currentUser?.uid;
    return Scaffold(
      body: Column(
        children: [
          AmigoHeader(title: 'Order details', onBack: () => Navigator.pop(context)),
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .collection('orders')
                  .doc(orderID)
                  .snapshots(),
              builder: (c, snapshot) {
                if (!snapshot.hasData) return circularProgress();
                final data = snapshot.data!.data() as Map<String, dynamic>?;
                if (data == null) {
                  return const EmptyState(
                      icon: Icons.receipt_long_outlined, message: 'Order not found.');
                }
                final stage = stageFromStatus(data['status'] as String?);
                final total = (data['totalAmount'] as num?) ?? 0;
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SellerName(
                            sellerUID: data['sellerUID'] as String?,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: kColorInk),
                          ),
                        ),
                        PickupCodeChip(orderID: orderID!),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(_formatOrderTime(data['orderTime']),
                        style: const TextStyle(fontSize: 12, color: kColorMuted)),
                    const SizedBox(height: 20),
                    const SectionLabel('Status'),
                    const SizedBox(height: 6),
                    stage == OrderStage.rejected
                        ? const Text("The stall couldn't take this order.",
                            style: TextStyle(color: Color(0xffb91c1c)))
                        : OrderTracker(stage: stage),
                    if (stage == OrderStage.collected) ...[
                      const SizedBox(height: 12),
                      RatingRow(
                          orderID: orderID!,
                          rating: (data['rating'] as num?)?.toInt()),
                    ],
                    const SizedBox(height: 20),
                    const SectionLabel('Items'),
                    const SizedBox(height: 6),
                    OrderItemsSummary(quantities: orderQuantities(data['productIDs'])),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: kColorInk)),
                        Text(rupees(total),
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: kColorInk)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text((data['paymentDetails'] as String?) ?? '',
                        style: const TextStyle(fontSize: 12, color: kColorMuted)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
