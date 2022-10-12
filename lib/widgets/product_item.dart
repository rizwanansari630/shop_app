import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/product.dart';
import 'package:flutter_complete_guide/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import 'badge.dart';

class ProductItem extends StatelessWidget {
  openProductDetailPage(BuildContext context, String productId) {
    Navigator.of(context)
        .pushNamed(ProductDetailScreen.routeName, arguments: productId);
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      elevation: 5.0,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: GridTile(
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            onTap: () => openProductDetailPage(context, product.id),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: Consumer<Product>(
              builder: (context, value, child) => IconButton(
                  icon: Icon(product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border_outlined),
                  onPressed: () {
                    product.toggleFavoriteStatus();
                  },
                  color: product.isFavorite
                      ? Colors.white
                      : Theme.of(context).accentColor),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: Consumer<Cart>(
              builder: ((context, cart, ch) {
                return cart.productCount(product.id) == 0
                    ? IconButton(
                        icon: Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          cart.addCartItem(
                              product.id, product.price, product.title);
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Item added to the cart'),
                              duration: Duration(seconds: 2),
                              padding: EdgeInsets.only(
                                  left: 15, top: 20, bottom: 20),
                              elevation: 4,
                              backgroundColor:
                                  Theme.of(context).primaryColorLight,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                            ),
                          );
                        },
                        color: Theme.of(context).accentColor)
                    : Badge(
                        child: ch,
                        value: cart.productCount(product.id).toString());
              }),
              child: IconButton(
                icon: Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  cart.addCartItem(product.id, product.price, product.title);
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Item added to the cart',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                      ),
                      action: SnackBarAction(
                          onPressed: () {
                            cart.removeCartItem(product.id);
                          },
                          label: 'UNDO',
                          textColor: Theme.of(context).primaryColor),
                      duration: Duration(seconds: 2),
                      padding: EdgeInsets.only(left: 15, top: 20, bottom: 20),
                      elevation: 4,
                      backgroundColor: Theme.of(context).primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                    ),
                  );
                },
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
