import 'package:shopappstmg/screens/productmanagescreen.dart';
import 'package:shopappstmg/screens/editingscreen.dart';
import 'package:shopappstmg/models/productmodel.dart';
import 'package:flutter/material.dart';

class UserProductList extends StatelessWidget {
  Product prod;

  UserProductList(this.prod);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(prod.productName),
      subtitle: Text('Rs.${prod.price}'),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(prod.imageUrl),
        radius: 20.0,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.mode_edit,
                color: Colors.blue.shade700,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red.shade500,
              onPressed: () {}),
        ],
      ),
    );
  }
}
