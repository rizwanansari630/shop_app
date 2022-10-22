import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/UiUtils.dart';
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
        body: Container(
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
                          child:
                              Text('\$${cart.totalAmount.toStringAsFixed(2)}')),
                      backgroundColor: Theme.of(context).primaryColorLight,
                    ),
                    OrderButton(order: order, cart: cart),
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
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.order,
    @required this.cart,
  }) : super(key: key);

  final Orders order;
  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FlatButton(
          onPressed: widget.cart.totalAmount <= 0
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    await widget.order.addOrder(
                        widget.cart.items.values.toList(),
                        widget.cart.totalAmount);
                    widget.cart.clearCart();
                    setState(() {
                      _isLoading = false;
                    });
                  } catch (error) {
                    _isLoading = false;
                  }
                },
          child: Text('Order Now'),
          textColor: Theme.of(context).primaryColor,
        ),
        if(_isLoading ) Container(
          padding: EdgeInsets.only(right: 12),
          child: SizedBox(
          child: CircularProgressIndicator(strokeWidth: 3),
          height: 15.0,
          width: 15.0,

        ),),
      ],
    );
  }
}
