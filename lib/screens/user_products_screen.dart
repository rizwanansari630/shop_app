import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = 'user-product-screen';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Products'),
      ),
      drawer: AppDrawer(),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  UserProductItem(
                    title: products[index].title,
                    imgUrl: products[index].imageUrl,
                  ),
                  Divider()
                ],
              );
            },
            itemCount: products.length,
          )),
    );
  }
}
