import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/custom_exception.dart';
import 'package:flutter_complete_guide/widgets/product_item.dart';
import 'package:http/http.dart' as http;

import '../providers/cart.dart' show Cart, CartItem;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({@required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final url =
  Uri.https('shop-app-698be-default-rtdb.firebaseio.com', '/order.json');

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double totalAmount) async {
    try {
      final timestamp = DateTime.now();
      final response = await http.post(url,
          body: json.encode({
            'amount': totalAmount,
            'products': cartProducts.map((cp) =>
            {
              'id': cp.id,
              'title': cp.title,
              'price': cp.price,
              'quantity': cp.quantity,
            }).toList(),
            'dateTime': timestamp.toIso8601String(),
          }));
      if (response.body.isNotEmpty) {
        var body = json.decode(response.body);
        print(body.toString());
        final orderItem = OrderItem(
            id: body['name'],
            amount: totalAmount,
            products: cartProducts,
            dateTime: timestamp);
        _orders.add(orderItem);
        notifyListeners();
      }
    } catch (error) {
      throw CustomException("Something went wrong");
    }
  }

  OrderItem getOrders(orderIndex) {
    return _orders[orderIndex];
  }

  Future<OrderItem> fetchOrders() async {
    final result = await http.get(url);
    if (result.body != null) {
      final extractedResult = json.decode(result.body) as Map<String, dynamic>;
      final List<OrderItem> loadedOrders = [];
      extractedResult.forEach((orderId, order) {
        loadedOrders.add(OrderItem(id: orderId,
            amount: order['amount'],
            products: (order['products'] as List<dynamic>).map((cart) =>
                CartItem(
                  id: cart["id"],
                  title: cart["title"],
                  quantity: cart["quantity"],
                  price: cart["price"],),).toList(),
            dateTime: DateTime.parse(order["dateTime"])));
      });
      _orders = loadedOrders;
      _orders.reversed.toList();
      notifyListeners();
    }
  }
}
