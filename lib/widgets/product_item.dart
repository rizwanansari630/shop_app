import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/product.dart';
import 'package:flutter_complete_guide/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  openProductDetailPage(BuildContext context, String productId) {
    Navigator.of(context)
        .pushNamed(ProductDetailScreen.routeName, arguments: productId);
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
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
            trailing: IconButton(
                icon: Icon(Icons.shopping_cart_outlined),
                onPressed: () {},
                color: Theme.of(context).accentColor),
          ),
        ),
      ),
    );
  }
}
