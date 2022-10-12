import 'package:flutter/material.dart';

import '../providers/cart.dart' show Cart, CartItem;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double totalAmount) {
    final orderItem = OrderItem(
        id: DateTime.now().toString(),
        amount: totalAmount,
        products: cartProducts,
        dateTime: DateTime.now());
    _orders.add(orderItem);
    print("orders length ${_orders.length.toString()}");
    notifyListeners();
  }

  OrderItem getOrders(orderIndex){
    return _orders[orderIndex];
  }
}
