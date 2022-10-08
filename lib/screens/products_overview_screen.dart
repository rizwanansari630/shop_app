import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/UiUtils.dart';
import 'package:flutter_complete_guide/app_constatns.dart';
import '../widgets/products_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(AppConstants.shopName),
      body: ProductsGrid(),
    );
  }
}


