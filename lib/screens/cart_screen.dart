import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/UiUtils.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartProductIds = cart.getAllAddedProductId();
    final order = Provider.of<Orders>(context);
    return Scaffold(
      appBar: buildAppBar('Cart Items (${cart.cartCount})', false),
      body: cart.cartCount > 0
          ? Container(
        color: Colors.orange,
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Total Amount'),
                  Spacer(),
                  Chip(
                    label: FittedBox(
                        child: Text(
                            '\$${cart.totalAmount.toStringAsFixed(2)}')),
                    backgroundColor:
                    Theme.of(context).primaryColorLight,
                  ),
                  FlatButton(
                    onPressed: () {
                      order.addOrder(cart.items.values.toList(), cart.totalAmount);
                      },
                    child: Text('Order Now'),
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CartItem(cartProductIds[index]);
                    },
                    itemCount: cart.items.length,
                  ),
                  Divider(
                    color: Colors.grey,
                    indent: 10,
                    endIndent: 10,
                    thickness: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('Write instructions for size',
                        textAlign: TextAlign.start),
                  )
                ],
              ),
            ),
          ],
        ),
      )
          : Center(child: Text('Opps..No Items in the cart.')),
    );
  }
}
