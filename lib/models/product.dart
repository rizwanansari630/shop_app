import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'custom_exception.dart';

class Product with ChangeNotifier {
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

  Future<void> toggleFavoriteStatus() async{
    final url = Uri.https('shop-app-698be-default-rtdb.firebaseio.com',
        '/product/$id.json');
    final currentState = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final updateProductResult =
    await http.patch(url, body: json.encode({"isFavorite": !currentState}));
    if (updateProductResult.statusCode >= 400) {
      isFavorite = currentState;
      notifyListeners();
      throw CustomException(
          "Something went wrong, Couldn't mark item as favorite at this moment ");
    } else {
      print("else");
    }
  }
}
