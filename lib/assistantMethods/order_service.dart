import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_amigo_app/constants.dart';

/// Writes the order to the student's history and to the shared `orders`
/// collection the vendor app listens to. Same fields as the original app.
Future<String> placeOrder({
  required String sellerUID,
  required num totalAmount,
}) async {
  final uid = sharedPreferences!.getString('uid') ?? firebaseAuth.currentUser!.uid;
  final orderId = DateTime.now().millisecondsSinceEpoch.toString();
  final data = <String, dynamic>{
    'totalAmount': totalAmount,
    'orderBy': uid,
    'productIDs': sharedPreferences!.getStringList('userCart'),
    'paymentDetails': 'Pay at pickup',
    'orderTime': orderId,
    'isSuccess': true,
    'sellerUID': sellerUID,
    'status': 'normal',
    'orderId': orderId,
  };

  final db = FirebaseFirestore.instance;
  final batch = db.batch();
  batch.set(db.collection('users').doc(uid).collection('orders').doc(orderId), data);
  batch.set(db.collection('orders').doc(orderId), data);
  await batch.commit();
  return orderId;
}

/// Stores a 1 to 5 star rating on both copies of the order, so the
/// university portal can report feedback per stall.
Future<void> rateOrder(String orderId, int rating) async {
  final uid = sharedPreferences!.getString('uid') ?? firebaseAuth.currentUser!.uid;
  final db = FirebaseFirestore.instance;
  final batch = db.batch();
  batch.update(db.collection('users').doc(uid).collection('orders').doc(orderId),
      {'rating': rating});
  batch.update(db.collection('orders').doc(orderId), {'rating': rating});
  await batch.commit();
}
