import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final String description;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.imageUrl,
      @required this.description,
      this.isFavorite = false});
}
