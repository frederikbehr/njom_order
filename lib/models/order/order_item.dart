import '../item/item.dart';

class OrderItem {
  double price;
  final Item item;
  int amount;

  OrderItem({required this.item, required this.price, required this.amount});

  void incrementAmount() {
    amount++;
    price = amount * item.price;
  }

  void decrementAmount() {
    amount--;
    price = amount * item.price;
  }

  @override
  String toString() => "$item::$price::$amount";

}