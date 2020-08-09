import 'package:shopappstmg/providermanagment/authmanagement.dart';
import 'package:shopappstmg/screens/editingscreen.dart';
import 'package:shopappstmg/screens/waitingscreen.dart';
import 'screens/productmanagescreen.dart';
import 'package:shopappstmg/providermanagment/ordermanagement.dart';
import 'package:shopappstmg/screens/orderscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providermanagment/productmanagement.dart';
import 'package:shopappstmg/screens/productoverviewscreen.dart';
import 'screens/product_desc_page.dart';
import 'providermanagment/cartmanagement.dart';
import 'package:shopappstmg/screens/cartscreen.dart';
import 'screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthManager()),
        /*Create because of new instance*/
        ChangeNotifierProxyProvider<AuthManager, ProductManagement>(
          update: (context, instanceofAuth, instanceofProductManagement) =>
              ProductManagement(
            instanceofAuth.tokenData,
            instanceofProductManagement == null
                ? []
                : instanceofProductManagement.productsList,
            instanceofAuth.userid,
          ),
          create: null,
        ),
        ChangeNotifierProvider(create: (context) => CartManagement()),
        ChangeNotifierProxyProvider<AuthManager, OrdersManagement>(
          update: (context, authObj, ordersObj) => OrdersManagement(
              authObj.tokenData,
              ordersObj == null ? [] : ordersObj.orders,
              authObj.userid),
          create: null,
        ),
      ],
      child: Consumer<AuthManager>(
        builder: (context, data, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Colors.purple,
              primarySwatch: Colors.deepOrange,
              /*this keeps the font of the in LATO*/
              fontFamily: 'Lato'),
          home: data.isAuth
              ? ProductScreen()
              : FutureBuilder(
                  future: data.tryAutoLogin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? WaitingPage()
                          : AuthScreen(),
                ),
          routes: {
            ProductDesc.id: (context) => ProductDesc(),
            ProductScreen.id: (context) => ProductScreen(),
            CartScreen.id: (context) => CartScreen(),
            OrderScreen.id: (context) => OrderScreen(),
            ProductManager.id: (context) => ProductManager(),
            EditingPage.id: (context) => EditingPage(),
            AuthScreen.id: (context) => AuthScreen(),
            WaitingPage.id: (context) => WaitingPage(),
          },
        ),
      ),
    );
  }
}

/*Basically provider provides the instance of that
 ChangeNotifier class on which we worked and coded the getter and setter*/
