import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providermanagment/productmanagement.dart';
import 'package:shopappstmg/screens/productoverviewscreen.dart';
import 'screens/product_desc_page.dart';
import 'providermanagment/cartmanagement.dart';
import 'package:shopappstmg/screens/cartscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /*Create because of new instance*/
        ChangeNotifierProvider(create: (context) => ProductManagement()),
        ChangeNotifierProvider(create: (context) => CartManagement()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.purple,
            primarySwatch: Colors.deepOrange,
            /*this keeps the font of the in LATO*/
            fontFamily: 'Lato'),
        initialRoute: ProductScreen.id,
        routes: {
          ProductDesc.id: (context) => ProductDesc(),
          ProductScreen.id: (context) => ProductScreen(),
          CartScreen.id: (context) => CartScreen(),
        },
      ),
    );
  }
}

/*Basically provider provides the instance of that
 ChangeNotifier class on which we worked and coded the getter and setter*/
