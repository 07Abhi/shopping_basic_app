import 'package:provider/provider.dart';
import 'package:shopappstmg/providermanagment/productmanagement.dart';
import 'package:flutter/material.dart';

class ProductDesc extends StatelessWidget {
  static const String id = 'descpage';

  @override
  Widget build(BuildContext context) {
    final String productId = ModalRoute.of(context).settings.arguments;
    final productDetails =
        Provider.of<ProductManagement>(context,listen:false).getIntanceById(productId);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        title: Text(productDetails.productName),
      ),
    );
  }
}
