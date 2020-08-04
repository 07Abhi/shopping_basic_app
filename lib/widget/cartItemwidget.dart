import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopappstmg/providermanagment/cartmanagement.dart';

class CartItemWidget extends StatelessWidget {
  final String productName;
  final double price;
  final int quantity;
  final String id;
  final String productId;

  CartItemWidget(
      {this.productName, this.price, this.quantity, this.id, this.productId});

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartManagement>(context, listen: false);
    return Dismissible(
      /*We take id as key in the ValueKey*/
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white70,
          size: 40.0,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        margin: EdgeInsets.symmetric(horizontal: 15.0),
      ),
      //R to L
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Cart'),
                content: Text('Want to remove item?'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        //it will return the Future<Bool> which is false
                        Navigator.of(context).pop(false);
                      },
                      child: Text('Keep')),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text('Yes'))
                ],
              );
            });
      },
      onDismissed: (direction) {
        Provider.of<CartManagement>(context, listen: false)
            .removeItem(productId);
//        SnackBar snackBar = SnackBar(
//          content: Text('Item Removed'),
//          duration: Duration(seconds: 2),
//          action: SnackBarAction(
//            label: 'KEEP',
//            onPressed: () {
//              cartData.keepItem(productName, productId, price);
//            },
//            textColor: Colors.blue,
//            disabledTextColor: Colors.red,
//          ),
//        );
//        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text('Rs$price'),
                ),
              ),
            ),
            title: Text(productName),
            subtitle: Text('Total:- ${price * quantity}'),
            trailing: SingleChildScrollView(
              child: Container(
                width: 100.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('$quantity x'),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.add),
                          iconSize: 20.0,
                          onPressed: () {
                            cartData.increaseQty(productId);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.remove),
                          iconSize: 20.0,
                          onPressed: () {
                            cartData.decreaseQty(productId);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
