import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String productId;

  CartItem(this.productId);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context,listen: false);
    final cartItem = cart.cartItemById(productId);
    // final double totalPrice = productPrice * productQuantity;
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.rectangle),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.removeItem(productId);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  Text(cartItem.title,
                      style: TextStyle(color: Colors.grey, fontSize: 20)),
                  Text(cartItem.quantity.toString()),
                  Text("${cartItem.price}"),
                ],
              ),
            )),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                      color: Colors.grey, width: 1, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {},
                      iconSize: 20,
                      color: Colors.green),
                  Text('${cartItem.quantity}',
                      style: TextStyle(color: Colors.green)),
                  IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 20,
                      onPressed: () {
                        cart.addCartItem(
                            productId, cartItem.price, cartItem.title);
                      },
                      color: Colors.green),
                ],
              ),
            ),
            FittedBox(
                child: Padding(
                    padding:
                        EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                    child: Text(
                        '${(cartItem.quantity * cartItem.price).toStringAsFixed(3)}')))
          ],
        ),
      ),
    );
  }
}
