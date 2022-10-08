import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/UiUtils.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:provider/provider.dart';


class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail-screen';

  void findProductDetails(){

  }
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments;
    final productsDetail= Provider.of<Products>(context).findProductById(productId);

    return Scaffold(
      appBar: buildAppBar(productsDetail.title),
    );
  }
}
