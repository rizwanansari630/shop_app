import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/product.dart';
import 'package:flutter_complete_guide/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  openProductDetailPage(BuildContext context) {
    Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(15)),),
      elevation: 5.0,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: GridTile(
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(15)) ,
            onTap: () => openProductDetailPage(context),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: IconButton(icon: Icon(Icons.favorite),onPressed: (){},color: Theme.of(context).accentColor),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(icon: Icon(Icons.shopping_cart),onPressed: (){},color: Theme.of(context).accentColor),
          ),
        ),
      ),
    );
  }
}
