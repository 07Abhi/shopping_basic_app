import 'package:shopappstmg/screens/editingscreen.dart';
import 'package:shopappstmg/widget/userproductlist.dart';
import 'package:provider/provider.dart';
import 'package:shopappstmg/providermanagment/productmanagement.dart';
import 'package:flutter/material.dart';

class ProductManager extends StatelessWidget {
  static const String id = 'productmanagement';

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductManagement>(context).productsList;
    return Scaffold(
      appBar: AppBar(
        /*By this const these widget not build again*/
        title: const Text('Product Manager'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 20.0,
            onPressed: () {
              Navigator.pushNamed(context,EditingPage.id);
            },
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              UserProductList(productList[index]),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Divider(
                  height: 1.0,
                  color: Colors.grey.shade700,
                ),
              )
            ],
          );
        },
        itemCount: productList.length,
      ),
    );
  }
}
