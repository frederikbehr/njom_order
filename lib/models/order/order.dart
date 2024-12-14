import '../item/item.dart';
import 'order_stage.dart';

class Order {
  final String id;
  final List<Item> items;
  final String tableId;
  DateTime? timeReceived;
  double? amountToPay;
  OrderStage? orderStage;

  Order({
    required this.id,
    required this.items,
    required this.tableId,
    required this.timeReceived,
    required this.amountToPay,
    required this.orderStage,
  });

  void addMenuItem(Item item) => items.add(item);

  void reset() {
    items.clear();
    timeReceived = null;
    amountToPay = null;
    orderStage = null;
  }
}