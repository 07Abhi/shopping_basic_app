import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopappstmg/models/cartitem.dart';

class CartManagement extends ChangeNotifier {
  Map<String, CartItem> _cartItem = {};

  /*It will provide the Map*/
  Map<String, CartItem> get items => {..._cartItem};

  /*Here we are giving the length of the cartitems*/
  int get cartLength {
    return _cartItem.length;
  }

  /*Here we calculating cart value by taking every map entry*/
  double get totalAmt {
    double total = 0.0;
    _cartItem.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addItem(String productId, String productName, double price) {
    /*Here we are using Maps in built methods to carryout the work*/
    if (_cartItem.containsKey(productId)) {
      /*that item is already present in the cart we need to alter the quantity*/
      _cartItem.update(
        productId,
        (previouscartitem) => CartItem(
            productName: previouscartitem.productName,
            id: previouscartitem.id,
            price: previouscartitem.price,
            quantity: previouscartitem.quantity + 1),
      );
    } else {
      /*Here we are add the key if not present
      * keys are p1 p2 p3 p4
      * and id is DateTime.now()*/
      _cartItem.putIfAbsent(
        productId,
        () => CartItem(
            productName: productName,
            id: DateTime.now().toString(),
            price: price,
            quantity: 1),
      );
    }
    notifyListeners();
  }

  void increaseQty(String productId) {
    var data = _cartItem[productId];
    data.quantity += 1;
    notifyListeners();
  }

  void decreaseQty(String productId) {
    var data = _cartItem[productId];
    if (data.quantity == 1) {
      data.quantity = 1;
    } else {
      data.quantity -= 1;
    }
    notifyListeners();
  }

//this will remove the whole item with quantity.
  void removeItem(String id) {
    _cartItem.remove(id);
    notifyListeners();
  }

  //This is will decrease the quantity
  void removeSingleQuantity(String productId) {
    if (!_cartItem.containsKey(productId)) {
      return;
    }
    if (_cartItem[productId].quantity > 1) {
      _cartItem.update(
        productId,
        (value) => CartItem(
            productName: value.productName,
            id: value.id,
            price: value.price,
            quantity: value.quantity - 1),
      );
    } else {
      _cartItem.remove(productId);
    }
    notifyListeners();
  }

  void keepItem(String proName, String proId, double price) {
    if (!_cartItem.containsKey(proId)) {
      _cartItem.putIfAbsent(
          proId,
          () => CartItem(
              productName: proName, id: proId, price: price, quantity: 1));
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItem = {};
    notifyListeners();
  }
}
