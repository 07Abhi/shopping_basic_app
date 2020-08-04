import 'package:flutter/material.dart';
import 'package:shopappstmg/models/orders.dart';
import 'package:shopappstmg/models/cartitem.dart';

class OrdersManagement extends ChangeNotifier {
  List<Orders> _ordersData = [];

  List<Orders> get orders {
    return [..._ordersData];
  }

  void addOrders(List<CartItem> cartsData, double total) {
   _ordersData.insert(0, Orders(
       id: DateTime.now().toString(),
       dateTime: DateTime.now(),
       amount: total,
       cartData: cartsData));
    notifyListeners();
   }
}
