import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shopappstmg/providermanagment/cartmanagement.dart';
import 'package:shopappstmg/widget/cartItemwidget.dart';

class CartScreen extends StatelessWidget {
  static const String id = 'chatScreen';

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartManagement>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 4.0,
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      'Rs. ${cartData.totalAmt}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme
                        .of(context)
                        .primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Place Order',
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return CartItemWidget(
                  productName: cartData.items.values.toList()[index].productName,
                  productId: cartData.items.keys.toList()[index],
                  price: cartData.items.values.toList()[index].price,
                  id: cartData.items.values.toList()[index].id,
                  quantity: cartData.items.values.toList()[index].quantity,);
            }, itemCount: cartData.items.length,),
          )
        ],
      ),
    );
  }
}
