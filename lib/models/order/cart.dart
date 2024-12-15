import 'package:nom_order/models/order/order_item.dart';

import '../item/item.dart';
import 'order.dart';
import 'order_stage.dart';

class Cart {
  final List<Item> items;
  final String tableId;

  Cart({
    required this.items,
    required this.tableId,
  });

  void addMenuItem(Item item) {
    items.add(item);
  }

  double getTotal() {
    double result = 0;
    for (Item item in items) {
      result += item.price;
    }
    return result;
  }

  void reset() => items.clear();

  bool contains(Item item) {
    if (items.indexWhere((e) => e.id == item.id) != -1) return true;
    return false;
  }

  List<OrderItem> createOrderItemList() {
    final List<OrderItem> orderItems = [];
    int findIndex(Item item) => orderItems.indexWhere((e) => e.item.title == item.title
        && e.item.description == item.description);
    for (Item item in items) {
      final int index = findIndex(item);
      if (index == -1) {
        //does not exist
        orderItems.add(OrderItem(item: item, price: item.price, amount: 1));
      } else {
        //increment amount
        orderItems[index].incrementAmount();
      }
    }
    return orderItems;
  }

  MenuOrder makeOrder() {
    return MenuOrder(
      items: createOrderItemList(),
      tableId: tableId,
      orderCreated: DateTime.now(),
      totalPrice: getTotal(),
      stage: OrderStage.received,
      id: 'not set',
    );
  }

}