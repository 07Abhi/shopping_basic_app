import 'dart:math';
import 'package:shopappstmg/models/orders.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class OrderWidget extends StatefulWidget {
  final Orders orders;

  OrderWidget(this.orders);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Rs. ${widget.orders.amount}'),
            subtitle: Text(
                'On Date  ${widget.orders.dateTime}'),
            trailing: IconButton(
              icon:
                  _expanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 4.0),
              height: min(widget.orders.cartData.length * 20 + 30.0, 100.0),
              child: ListView(
                  children: widget.orders.cartData
                      .map(
                        (instance) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              instance.productName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                            ),
                            Text(
                              '${instance.quantity}x Rs.${instance.price}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0,color: Colors.grey),
                            )
                          ],
                        ),
                      )
                      .toList()),
            ),
        ],
      ),
    );
  }
}
//here instance is the instance of order class
