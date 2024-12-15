import 'package:nom_order/models/order/order_item.dart';
import 'order_stage.dart';

class MenuOrder {
  final String id;
  final List<OrderItem> items;
  final String tableId;
  final DateTime orderCreated;
  double totalPrice;
  final OrderStage stage;

  MenuOrder({
    required this.id,
    required this.items,
    required this.tableId,
    required this.orderCreated,
    required this.totalPrice,
    required this.stage,
  });

  List<String> getItemsAsString() => items.map((e) => e.toString()).toList();

  void removeItem(OrderItem item) {
    items.remove(item);
    updateTotalPrice();
  }
  void decrementItem(OrderItem item) {
    if (item.amount == 1) {
      removeItem(item);
    } else {
      item.decrementAmount();
    }
    updateTotalPrice();
  }

  void updateTotalPrice() {
    double result = 0;
    for (OrderItem item in items) {
      result += item.price;
    }
    totalPrice = result;
  }

}