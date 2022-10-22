import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart' as ord;
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<ord.Orders>(context, listen: false).fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Consumer<ord.Orders>(
                builder: (context, ordersData, child) => ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return OrderItem(ordersData.orders[index]);
                    },
                    itemCount: ordersData.orders.length),
              );
            }
          }
        },
      ),
    );
  }
}
