import 'package:intl/intl.dart';
import 'package:shopappstmg/models/http_exceptions.dart';
import 'dart:convert' as json;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shopappstmg/models/orders.dart';
import 'package:shopappstmg/models/cartitem.dart';

class OrdersManagement extends ChangeNotifier {
  String authKey;
  List<Orders> _ordersData = [];
  String userId;

  OrdersManagement(this.authKey, this._ordersData, this.userId);

  List<Orders> get orders {
    return [..._ordersData];
  }

  void addOrders(List<CartItem> cartsData, double total) async {
    var timeOfOrder = DateFormat('dd/MM/yyyy hh:mm a E').format(DateTime.now());
    var timeStamp = DateTime.now();
    final String url =
        'https://shopapp-71278.firebaseio.com/orderdata.json?auth=$authKey';
    http.Response response = await http.post(url,
        body: json.jsonEncode({
          'orderDate': timeOfOrder,
          'totalAmount': total,
          'userId': userId,
          //this will convert the list to map item list.
          'cartitems': cartsData
              .map((e) => {
                    'id': e.id,
                    'productName': e.productName,
                    'quantity': e.quantity,
                    'price': e.price,
                  })
              .toList(),
        }));
    if (response.statusCode == 200) {
      _ordersData.insert(
          0,
          Orders(
              id: json.jsonDecode(response.body)['name'],
              dateTime: timeStamp.toString(),
              amount: total,
              cartData: cartsData));
      notifyListeners();
    } else {
      throw HttpException('Unable to Request');
    }
  }

  Future<void> fetchAndSetData() async {
    final String url =
        'https://shopapp-71278.firebaseio.com/orderdata.json?auth=$authKey&orderBy=\"userId\"&equalTo=\"$userId\"';
    print(url);
    http.Response response = await http.get(url);
    print(json.jsonDecode(response.body));
    List<Orders> helperList = [];
    final data = json.jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      if (data == null) {
        return null;
      }
      data.forEach((key, value) {
        helperList.add(Orders(
          id: key,
          amount: value['totalAmount'],
          dateTime: value['orderDate'],
          cartData: (value['cartitems'] as List<dynamic>)
              .map((e) => CartItem(
                  productName: e['productName'],
                  id: e['id'],
                  price: e['price'],
                  quantity: e['quantity']))
              .toList(),
        ));
      });
      _ordersData = helperList.reversed.toList();
      notifyListeners();
    }
  }
}
