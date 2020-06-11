import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      color: Color.fromRGBO(220, 220, 220, 0.3),
      child: Container(
        padding: EdgeInsets.only(right:10),
        height: 30,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0))
        ),
        width: MediaQuery.of(context).size.width*0.75,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.search,color: Colors.grey,size:16.0),
            Container(width: 5,),
            Text("搜索",style: TextStyle(color:Colors.grey,fontSize:14),)
          ],
        )
      )
    );
  }
}