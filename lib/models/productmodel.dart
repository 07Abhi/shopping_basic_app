import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class Product with ChangeNotifier {
  final String id;
  final String desc;
  final String imageUrl;
  final double price;
  final productName;
  bool isfavorite;

  Product(
      {@required this.id,
      @required this.price,
      @required this.desc,
      @required this.imageUrl,
      this.isfavorite = false,
      @required this.productName});

  void togglefav() {
    isfavorite = !isfavorite;
    notifyListeners();
  }
}
