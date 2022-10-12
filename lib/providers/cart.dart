import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String title;
  int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get cartCount {
    return _items.length;
  }

  int productCount(String productId) {
    if (_items.containsKey(productId)) {
      print(_items[productId].quantity.toString());
      return _items[productId].quantity;
    } else {
      return 0;
    }
  }

  void addCartItem(String productId, double price, String title) {
    print('add items');
    if (_items.containsKey(productId)) {
      print('update items');
      items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity++,
              price: existingCartItem.price));
      print('product qanty ${_items[productId].quantity}');
    } else {
      print('putIfAbsent items');
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  List<String> getAllAddedProductId(){
    return _items.keys.toList();
  }

   CartItem cartItemById(String productId){
    return _items[productId];
  }

  double get totalAmount{
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }
}
