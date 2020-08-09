import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

//final String url = 'https://shopapp-71278.firebaseio.com/products_data.json';
class Product with ChangeNotifier {
  final String id;
  final String userId;
  final String desc;
  final String imageUrl;
  final double price;
  final String productName;
  bool isfavorite = false;

  Product(
      {@required this.id,
      this.userId,
      @required this.price,
      @required this.desc,
      @required this.imageUrl,
      @required this.productName,
      this.isfavorite});

  void togglefav(String authKey, String userId) async {
    final url =
        'https://shopapp-71278.firebaseio.com/userfav_data/$userId/$id.json?auth=$authKey';
    var oldStatus = isfavorite;
    isfavorite = !isfavorite;
    notifyListeners();
    try {
      //not included await because it took sometime there.
      http.Response response = await http.put(
        url,
        body: jsonEncode(
          isfavorite,
        ),
      );
      if (response.statusCode >= 400) {
        isfavorite = oldStatus;
        notifyListeners();
      }
    } catch (e) {
      isfavorite = oldStatus;
      notifyListeners();
    }
  }
}
