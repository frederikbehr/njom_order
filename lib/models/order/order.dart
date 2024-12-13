import 'order_stage.dart';

class Order {
  final String id;
  final List<String> items;
  final String tableId;
  final DateTime timeReceived;
  final double amountToPay;
  final OrderStage orderStage;

  const Order({
    required this.id,
    required this.items,
    required this.tableId,
    required this.timeReceived,
    required this.amountToPay,
    required this.orderStage,
  });
}