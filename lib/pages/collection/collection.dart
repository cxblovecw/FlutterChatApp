import 'package:flutter/material.dart';

class Collection extends StatelessWidget{
  // 抽屉中 我的收藏功能
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.chevron_left),color: Colors.grey, onPressed: (){Navigator.pop(context);}),
        title:Text("我的收藏",style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16.0
        ),)
      ),
    );
  }
}