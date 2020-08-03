import 'dart:collection';

import 'package:shopappstmg/models/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductManagement with ChangeNotifier {
  List<Product> _productList = [
    Product(
      id: 'p1',
      productName: 'Red Shirt',
      desc: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      productName: 'Trousers',
      desc: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      productName: 'Yellow Scarf',
      desc: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      productName: 'A Pan',
      desc: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  //UnmodifiableListView<Product> get  productlist => UnmodifiableListView(_productList);
  /*This will give the product list*/
  List<Product> get productsList {
    return [..._productList];
  }
  /*This will give the favorites list*/
  List<Product> get favoritesList {
    return _productList.where((element) => element.isfavorite).toList();
  }

  Product getIntanceById(String Id) {
    /*Returning only the instance not list*/
    return _productList.firstWhere((element) => element.id == Id);
  }
}
