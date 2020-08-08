import 'package:shopappstmg/models/cartitem.dart';
import 'package:flutter/material.dart';

class Orders {
  final String id;
  final double amount;
  final String dateTime;
  final List<CartItem> cartData;

  Orders({
    @required this.id,
    @required this.dateTime,
    @required this.amount,
    @required this.cartData,
  });
}
