import 'package:shopappstmg/models/http_exceptions.dart';
import 'dart:convert' as json;
import 'package:http/http.dart' as http;
import 'package:shopappstmg/models/productmodel.dart';
import 'package:flutter/material.dart';

const url = 'https://shopapp-71278.firebaseio.com/products_data.json';

class ProductManagement with ChangeNotifier {
  List<Product> _productList = [];

  //UnmodifiableListView<Product> get  productlist => UnmodifiableListView(_productList);
  /*This will give the product list*/
  List<Product> get productsList {
    return [..._productList];
  }

  /*This will give the favorites list*/
  List<Product> get favoritesList {
    return _productList.where((element) => element.isfavorite).toList();
  }

  Future<void> fetchAndSetData() async {
    try {
      http.Response response = await http.get(url);
      var extractedData =
          json.jsonDecode(response.body) as Map<String, dynamic>;
      final List<Product> prodList = [];
      if (extractedData != null) {
        extractedData.forEach((prodId, value) {
          prodList.add(
            Product(
              id: prodId,
              productName: value['productName'],
              price: value['price'],
              imageUrl: value['imageUrl'],
              isfavorite: value['isFavorite'],
              desc: value['desc'],
            ),
          );
        });
        _productList = prodList;
        notifyListeners();
      }
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> addItem(Product prod) async {
    http.Response response = await http.post(
      url,
      body: json.jsonEncode(
        {
          'productName': prod.productName,
          'price': prod.price,
          'desc': prod.desc,
          'imageUrl': prod.imageUrl,
          'isFavorite': prod.isfavorite
        },
      ),
    );
    if (response.statusCode == 200) {
      var jsonData = json.jsonDecode(response.body);
      var newProduct = Product(
        productName: prod.productName,
        price: prod.price,
        imageUrl: prod.imageUrl,
        desc: prod.desc,
        id: jsonData['name'],
      );
      _productList.add(newProduct);
      notifyListeners();
      return true;
    } else {
      print('Problem in Request');
      return false;
    }
  }

  Product getIntanceById(String Id) {
    /*Returning only the instance not list*/
    return _productList.firstWhere((element) => element.id == Id);
  }

  Future<void> updateProductData(String id, Product newProd) async {
    final updateUrl =
        'https://shopapp-71278.firebaseio.com/products_data/$id.json';
    http.patch(updateUrl,
        body: json.jsonEncode({
          'desc': newProd.desc,
          'imageUrl': newProd.imageUrl,
          'isFavorite': newProd.isfavorite,
          'price': newProd.price,
          'productName': newProd.productName,
        }));
    var index = _productList.indexWhere((element) => element.id == id);
    if (index >= 0) {
      _productList[index] = newProd;
      notifyListeners();
    } else {
      print('No data Attached');
    }
  }

  void deleteItem(String id) async {
    //here we use the concept of optimizing deletion.
    final updateUrl =
        'https://shopapp-71278.firebaseio.com/products_data/$id.json';
    var index = _productList.indexWhere((element) => element.id == id);
    var productItem = _productList[index];
    if (id != null) {
      _productList.removeAt(index);
      //If the data is not deleted from the request then we re added it to the list again.
      http.Response response = await http.delete(updateUrl);
      //now if the request is successful then we make that to null Dart clear the clutter.
      if (response.statusCode > 400) {
        _productList.insert(index, productItem);
        notifyListeners();
        throw HttpException('Could not resolve the error');
      }
      productItem = null;
      notifyListeners();
    }
  }
}
