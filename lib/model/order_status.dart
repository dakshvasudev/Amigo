/// Order lifecycle shown to students.
///
/// The student app writes "normal" when an order is placed. The vendor app
/// moves it forward ("preparing", "ready", "ended"), or sets "rejected".
/// "accepted" and "collected" are accepted as aliases.
enum OrderStage { placed, preparing, ready, collected, rejected }

OrderStage stageFromStatus(String? status) {
  switch (status) {
    case 'preparing':
    case 'accepted':
      return OrderStage.preparing;
    case 'ready':
      return OrderStage.ready;
    case 'ended':
    case 'collected':
      return OrderStage.collected;
    case 'rejected':
      return OrderStage.rejected;
    default:
      return OrderStage.placed;
  }
}

const List<OrderStage> trackedStages = [
  OrderStage.placed,
  OrderStage.preparing,
  OrderStage.ready,
  OrderStage.collected,
];

const Map<OrderStage, String> _labels = {
  OrderStage.placed: 'Order placed',
  OrderStage.preparing: 'Being prepared',
  OrderStage.ready: 'Ready for pickup',
  OrderStage.collected: 'Collected',
  OrderStage.rejected: 'Rejected',
};

String stageLabel(OrderStage stage) => _labels[stage] ?? '';

bool isActive(OrderStage stage) =>
    stage == OrderStage.placed ||
    stage == OrderStage.preparing ||
    stage == OrderStage.ready;

/// Short code the student shows at the counter, derived from the order ID.
String pickupCode(String orderID) {
  final digits = orderID.replaceAll(RegExp(r'[^0-9]'), '');
  final tail = digits.length >= 3
      ? digits.substring(digits.length - 3)
      : digits.padLeft(3, '0');
  return 'A$tail';
}
