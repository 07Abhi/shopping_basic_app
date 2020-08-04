import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String productName;
   int quantity;
  final double price;

  CartItem(
      {@required this.productName,
      @required this.id,
      @required this.price,
      @required this.quantity});
}
