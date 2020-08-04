import 'package:provider/provider.dart';
import 'package:shopappstmg/providermanagment/productmanagement.dart';
import 'package:flutter/material.dart';

class ProductDesc extends StatelessWidget {
  static const String id = 'descpage';

  @override
  Widget build(BuildContext context) {
    final String productId = ModalRoute.of(context).settings.arguments;
    final productDetails =
        Provider.of<ProductManagement>(context, listen: false)
            .getIntanceById(productId);
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              height: 300.0,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                productDetails.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'Rs.${productDetails.price}/-',
              style: TextStyle(
                  color: Colors.grey.shade700,
                  letterSpacing: 1.0,
                  fontSize: 20.0),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                productDetails.desc,
                style: TextStyle(color: Colors.black45, fontSize: 18.0),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
