//import '';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopappstmg/widget/productdisplaywidget.dart';
import 'package:shopappstmg/providermanagment/productmanagement.dart';
class ProductWidget extends StatelessWidget {
  bool showFav;

  ProductWidget({this.showFav});

  @override
  Widget build(BuildContext context) {
    /*
    * instead of consumers we can directly use
    * final product_data = Provider.of<ProductManagement>(context);
    * then  final data  product_data.getter of the class
    * then we use it in the builder widget*/
    final product_data = Provider.of<ProductManagement>(context);
    final productwiseList =
        showFav ? product_data.favoritesList : product_data.productsList;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: productwiseList.length,
      itemBuilder: (context, index) {
        //if our class not want context.
        // if we working on already made objects.
        return ChangeNotifierProvider.value(
          value: productwiseList[index],
          child: ProductDisplay(productwiseList[index]),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 3 / 2,
      ),
    );
  }
}
