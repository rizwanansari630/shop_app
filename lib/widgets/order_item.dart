import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<ord.Orders>(context);
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd-MM-yyyy, hh:mm').format(widget.order.dateTime)),
            trailing: isExpanded
                ? Icon(Icons.arrow_drop_up)
                : Icon(Icons.arrow_drop_down),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
          if (isExpanded)
            Container(
              height: min(widget.order.products.length * 20.0 + 400,250),
              child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (context, index) {
                  final products = widget.order.products[index];
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(products.title),
                        Spacer(),
                        Text('Qty. ${products.quantity}'),
                        Text(' * ${products.price.toStringAsFixed(2)}'),
                        Spacer(),
                        CircleAvatar(child: FittedBox(child: Text('${products.quantity * products.price}')),),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
