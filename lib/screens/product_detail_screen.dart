import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/UiUtils.dart';


class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail-screen';

  void findProductDetails(){

  }
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      appBar: buildAppBar('product detail page'),
    );
  }
}
