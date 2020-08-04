import 'package:flutter/material.dart';
class DrawerTile extends StatelessWidget {
  String titleText;
  Function func;
  IconData icon;
  DrawerTile({this.titleText,this.func,this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:Border(bottom:BorderSide(color: Colors.blueGrey,width: 2.0)),
      ),
      child: InkWell(
        onTap: func,
        splashColor: Theme.of(context).primaryColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(icon,size: 30.0,),
            Text(titleText,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,),)
          ],
        ),
      ),
    );
  }
}
