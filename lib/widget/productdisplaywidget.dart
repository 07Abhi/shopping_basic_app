import 'package:shopappstmg/providermanagment/authmanagement.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopappstmg/providermanagment/cartmanagement.dart';
import 'package:shopappstmg/screens/product_desc_page.dart';
import 'package:shopappstmg/models/productmodel.dart';

class ProductDisplay extends StatelessWidget {
  bool favStatus = false;
  Product prods;

  ProductDisplay(this.prods);

  @override
  Widget build(BuildContext context) {
    final productInfo = Provider.of<Product>(context);
    final cartInfo = Provider.of<CartManagement>(context);
    final authData = Provider.of<AuthManager>(context);
    favStatus = productInfo.isfavorite;
    print(favStatus);
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            ProductDesc.id,
            arguments: prods.id,
          );
        },
        child: Image.network(
          prods.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black38,
        trailing: IconButton(
          icon: Icon(CupertinoIcons.shopping_cart),
          color: Colors.white,
          onPressed: () {
            cartInfo.addItem(prods.id, prods.productName, prods.price);
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
                  ).removeSingleQuantity(prods.id);
                },
                textColor: Colors.blue,
                disabledTextColor: Colors.red,
              ),
            );
            Scaffold.of(context).showSnackBar(snackBar);
          },
        ),
        title: Text(
          prods.productName,
          textAlign: TextAlign.center,
          overflow: TextOverflow.fade,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.favorite,
            color: favStatus??false ? Colors.red : Colors.white70,
          ),
          color: Colors.white70,
          onPressed: () {
            Provider.of<Product>(context, listen: false)
                .togglefav(authData.tokenData, authData.userid);
          },
        ),
      ),
    );
  }
}
/*We cannot use the keyGlobal<ScaffoldState> because scaffold is not present here*/
