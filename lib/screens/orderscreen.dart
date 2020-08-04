import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopappstmg/providermanagment/ordermanagement.dart';
import 'package:shopappstmg/widget/ordertilewidget.dart';

class OrderScreen extends StatelessWidget {
  static const String id = 'orderscreenId';
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<OrdersManagement>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return OrderWidget(ordersData.orders[index]);
        },
        itemCount: ordersData.orders.length,
        shrinkWrap: true,
      ),
    );
  }
}
