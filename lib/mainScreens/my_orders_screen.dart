import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_amigo_app/constants.dart';
import 'package:user_amigo_app/widgets/amigo_ui.dart';
import 'package:user_amigo_app/widgets/order_card.dart';
import 'package:user_amigo_app/widgets/progress_bar.dart';

/// Live list of the student's orders. Status changes made by the vendor
/// stream in through Firestore, so the tracker updates without a refresh.
class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = sharedPreferences!.getString('uid') ?? firebaseAuth.currentUser?.uid;
    return Column(
      children: [
        const AmigoHeader(title: 'Your orders'),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .collection('orders')
                .orderBy('orderTime', descending: true)
                .snapshots(),
            builder: (c, snapshot) {
              if (!snapshot.hasData) return circularProgress();
              final docs = snapshot.data!.docs;
              if (docs.isEmpty) {
                return const EmptyState(
                    icon: Icons.receipt_long_outlined, message: 'No orders yet.');
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: docs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (c, i) => OrderCard(
                  orderID: docs[i].id,
                  data: docs[i].data()! as Map<String, dynamic>,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
