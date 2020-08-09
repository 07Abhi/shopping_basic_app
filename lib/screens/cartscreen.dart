import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shopappstmg/providermanagment/cartmanagement.dart';
import 'package:shopappstmg/providermanagment/ordermanagement.dart';
import 'package:shopappstmg/widget/cartItemwidget.dart';

class CartScreen extends StatefulWidget {
  static const String id = 'chatScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isList = false;
  bool isLoading = false;
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartManagement>(context);
    isList = cartData.isListempty();
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
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
                        'Rs. ${cartData.totalAmt.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    Visibility(
                      visible: isList ? false : true,
                      child: FlatButton(
                        onPressed: () async {
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            await Provider.of<OrdersManagement>(context,
                                    listen: false)
                                .addOrders(cartData.items.values.toList(),
                                    cartData.totalAmt);
                            cartData.clearCart();
                          } catch (e) {
                            SnackBar snackBar = SnackBar(
                              content: Text('Unable to place order!!'),
                              duration: Duration(seconds: 3),
                            );
                            _scaffoldkey.currentState.showSnackBar(snackBar);
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: Text(
                          'Place Order',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CartItemWidget(
                    productName:
                        cartData.items.values.toList()[index].productName,
                    productId: cartData.items.keys.toList()[index],
                    price: cartData.items.values.toList()[index].price,
                    id: cartData.items.values.toList()[index].id,
                    quantity: cartData.items.values.toList()[index].quantity,
                  );
                },
                itemCount: cartData.items.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
