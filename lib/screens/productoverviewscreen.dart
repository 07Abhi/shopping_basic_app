import 'package:provider/provider.dart';
import 'package:shopappstmg/providermanagment/cartmanagement.dart';
import 'package:shopappstmg/providermanagment/productmanagement.dart';
import 'package:shopappstmg/widget/badge.dart';
import '../models/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:shopappstmg/widget/productdisplaywidget.dart';
import 'package:shopappstmg/widget/productwidget.dart';
import 'package:flutter/cupertino.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductScreen extends StatefulWidget {
  static const String id = 'productscreen';

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    //final cartData = Provider.of<CartManagement>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: <Widget>[
          Consumer<CartManagement>(
            builder: (context, cartData, ch) => Badge(
              child: ch,
              value: cartData.cartLength.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions val) {
              setState(() {
                if (val == FilterOptions.Favorites) {
                  _showFavorites = true;
                } else {
                  _showFavorites = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Your Favorites'),
                  value: FilterOptions.Favorites),
              PopupMenuItem(
                  child: Text('All Products'), value: FilterOptions.All),
            ],
          )
        ],
      ),
      body: ProductWidget(showFav: _showFavorites),
    );
  }
}
