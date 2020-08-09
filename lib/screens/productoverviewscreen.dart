import 'package:shopappstmg/providermanagment/authmanagement.dart';
import 'package:shopappstmg/providermanagment/productmanagement.dart';
import 'package:toast/toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shopappstmg/screens/productmanagescreen.dart';
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
  bool init = true;
  bool _isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void checkInternet() async {
    var connectionChecker = await (Connectivity().checkConnectivity());
    if (connectionChecker != ConnectivityResult.mobile &&
        connectionChecker != ConnectivityResult.wifi) {
      SnackBar snackBar = SnackBar(
        content: Text('No Internet access....'),
        duration: Duration(seconds: 3),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

/*In The initState no context related work carried out
because may be rebuild affect the build State*/
  @override
  void initState() {
    super.initState();
    checkInternet();
  }

  @override
  void didChangeDependencies() {
    if (init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductManagement>(context).fetchAndSetData().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
    init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                } else if (val == FilterOptions.All) {
                  _showFavorites = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Your Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('All Products'),
                value: FilterOptions.All,
              ),
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
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              child: DrawerTile(
                titleText: 'My Orders',
                func: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, OrderScreen.id);
                },
                icon: Icons.history,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              child: DrawerTile(
                titleText: 'Product Manager',
                func: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, ProductManager.id);
                },
                icon: Icons.settings_applications,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              child: DrawerTile(
                titleText: 'Logout',
                func: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                              'My Shop',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: Text('Want to logout?'),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                color: Theme.of(context).primaryColor,
                                child: Text(
                                  'No',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Provider.of<AuthManager>(context,
                                          listen: false)
                                      .userLogout();
                                  Toast.show(
                                    'Logout Succesfully',
                                    context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM,
                                    backgroundColor: Colors.black87,
                                    textColor: Colors.white70,
                                  );
                                },
                                color: Theme.of(context).primaryColor,
                                child: Text(
                                  'yes',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ));
                },
                icon: Icons.exit_to_app,
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductWidget(showFav: _showFavorites),
    );
  }
}
