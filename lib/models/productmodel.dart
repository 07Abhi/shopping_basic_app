import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

//final String url = 'https://shopapp-71278.firebaseio.com/products_data.json';
class Product with ChangeNotifier {
  final String id;
  final String desc;
  final String imageUrl;
  final double price;
  final String productName;
  bool isfavorite;

  Product(
      {@required this.id,
      @required this.price,
      @required this.desc,
      @required this.imageUrl,
      this.isfavorite = false,
      @required this.productName});

  void togglefav() async {
    final url = 'https://shopapp-71278.firebaseio.com/products_data/$id.json';
    var oldStatus = isfavorite;
    print(id);
    isfavorite = !isfavorite;
    notifyListeners();
    try {
    //not included await because it took sometime there.
       http.Response response = await http.patch(url,
          body: jsonEncode({
            'isFavorite': isfavorite,
          }));
     if(response.statusCode>=400){
       isfavorite = oldStatus;
       notifyListeners();
     }
    } catch (e) {
      isfavorite = oldStatus;
      notifyListeners();
    }
  }
}
