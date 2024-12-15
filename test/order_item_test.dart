import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nom_order/models/device/device_info.dart';
import 'package:nom_order/models/device/device_info_factory.dart';
import 'package:nom_order/models/device/device_mode.dart';
import 'package:nom_order/models/device/device_type.dart';
import 'package:nom_order/models/item/item.dart';
import 'package:nom_order/models/order/order.dart';
import 'package:nom_order/models/order/order_item_factory.dart';
import 'package:nom_order/models/order/order_item.dart';
import 'package:nom_order/models/order/order_stage.dart';

void main() async {

  test('Order to string and then from string to Order', () async {
    int fails = 0;
    final List<OrderItem> testScenarios = [
      OrderItem(
        item: const Item(id: "n123j1i3n1", title: "title", description: "description", price: 23.23, imageURL: null, category: "category"),
        price: 23.23,
        amount: 1,
      ),
      OrderItem(
        item: Item(id: "n123j1i3n1n123j1i3n1", title: "title title ", description: "description"*10, price: 23.23, imageURL: "https://www.d.dk/eef/fefw", category: "category"),
        price: 200,
        amount: 4,
      ),
    ];
    for (OrderItem orderItem in testScenarios) {
      final String orderItemString = orderItem.toString();
      try {
        OrderItem recreatedOrderItem = OrderItemFactory.stringToOrderItem(orderItemString);
        expect(recreatedOrderItem.toString(), orderItemString.toString());
      } catch(e) {
        debugPrint(e.toString());
        fails++;
      }
    }
    expect(fails, 0);
  });

}