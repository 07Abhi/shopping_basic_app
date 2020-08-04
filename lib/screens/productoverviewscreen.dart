import 'package:provider/provider.dart';
import 'package:shopappstmg/screens/orderscreen.dart';
import 'package:shopappstmg/providermanagment/cartmanagement.dart';
import 'package:shopappstmg/screens/cartscreen.dart';
import 'package:shopappstmg/widget/badge.dart';
import 'package:flutter/material.dart';
import 'package:shopappstmg/widget/productwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopappstmg/widget/drawerstile.dart';
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
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.id);
              },
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'My Cart',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Colors.pinkAccent, Colors.purple]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:10.0),
              child: DrawerTile(titleText:'My Orders',func: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, OrderScreen.id);

              },icon: Icons.history,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: DrawerTile(titleText:'Exit',func: (){},icon: Icons.exit_to_app,),
            ),
          ],
        ),
      ),
      body: ProductWidget(showFav: _showFavorites),
    );
  }
}
