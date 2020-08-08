import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopappstmg/models/orders.dart';
import 'package:shopappstmg/providermanagment/ordermanagement.dart';
import 'package:shopappstmg/widget/ordertilewidget.dart';

class OrderScreen extends StatelessWidget {
  static const String id = 'orderscreenId';

  //hack is this is called when build is called.
//    Future.delayed(Duration.zero).then((_) async {
//      setState(() {
//        _isLoading = true;
//      });
//      await Provider.of<OrdersManagement>(context, listen: false)
//          .fetchAndSetData();
//      setState(() {
//        _isLoading = false;
//      });
//    });

  @override
  Widget build(BuildContext context) {
    /*Thats why our future builder is running simultaneously*/
//    final ordersData = Provider.of<OrdersManagement>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<OrdersManagement>(
          context,
          listen: false,
        ).fetchAndSetData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return Center(child: Text('Error Occurred'));
            } else {
              return Consumer<OrdersManagement>(
                builder: (context, orderData, _) => ListView.builder(
                  itemBuilder: (context, index) =>
                      OrderWidget(orderData.orders[index]),
                  itemCount: orderData.orders.length,
                  shrinkWrap: true,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
/* _isLoading
        ? Scaffold(
            appBar: AppBar(
              title: Text('My Orders'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('My Orders'),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                return OrderWidget(ordersData.orders[index]);
              },
              itemCount: ordersData.orders.length,
              shrinkWrap: true,
            ),
          );*/
/*
*  if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else{
            if(snapshot.hasData){
              return,
            }*/
