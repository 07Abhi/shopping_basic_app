import 'package:toast/toast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopappstmg/providermanagment/cartmanagement.dart';
import 'package:shopappstmg/screens/product_desc_page.dart';
import 'package:shopappstmg/models/productmodel.dart';

class ProductDisplay extends StatelessWidget {
  bool favStatus = false;

  @override
  Widget build(BuildContext context) {
    final productInfo = Provider.of<Product>(context);
    final cartInfo = Provider.of<CartManagement>(context);
    favStatus = productInfo.isfavorite;
    return Consumer<Product>(
      builder: (context, productInfo, _) => GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductDesc.id,
              arguments: productInfo.id,
            );
          },
          child: Image.network(
            productInfo.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black38,
          trailing: IconButton(
            icon: Icon(CupertinoIcons.shopping_cart),
            color: Colors.white,
            onPressed: () {
             cartInfo.addItem(
                  productInfo.id, productInfo.productName, productInfo.price);
              Scaffold.of(context).hideCurrentSnackBar();
              SnackBar snackBar = SnackBar(
                content: Text('Item Added to Cart!!'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    Provider.of<CartManagement>(
                      context,
                      listen: false,
                    ).removeSingleQuantity(productInfo.id);
                  },
                  textColor: Colors.blue,
                  disabledTextColor: Colors.red,
                ),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            },
          ),
          title: Text(
            productInfo.productName,
            textAlign: TextAlign.center,
            overflow: TextOverflow.fade,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: favStatus ? Colors.red : Colors.white70,
            ),
            color: Colors.white70,
            onPressed: () {
              Provider.of<Product>(context, listen: false).togglefav();
            },
          ),
        ),
      ),
    );
  }
}
/*We cannot use the keyGlobal<ScaffoldState> because scaffold is not present here*/
