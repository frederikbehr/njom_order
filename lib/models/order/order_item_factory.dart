import 'package:nom_order/models/item/item.dart';
import 'package:nom_order/models/order/order_item.dart';

class OrderItemFactory {

  static OrderItem stringToOrderItem(String value) {
    final List<String> values = value.split("::");
    return OrderItem(
      item: Item(
        id: values[0],
        title: values[1],
        description: values[2],
        price: double.parse(values[3]),
        imageURL: values[4],
        category: values[5],
      ),
      price: double.parse(values[6]),
      amount: int.parse(values[7]),
    );
  }

}