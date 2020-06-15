import 'package:flutter/material.dart';


class SearchFriend extends StatefulWidget {
  @override
  _SearchFriendState createState() => _SearchFriendState();
}

class _SearchFriendState extends State<SearchFriend> {
  String condition="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:Text("搜索用户",style: TextStyle(color: Colors.black87),),
        centerTitle: true,
        leading: IconButton(icon:Icon(Icons.chevron_left,color:Colors.black87), onPressed:(){
          Navigator.pop(context);
        }),
      ),
      body: Container(
        color: Color.fromRGBO(200,200,200, 0.2),
        child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                border: InputBorder.none,
                hintText: "手机号码/账号"
              ),
              controller:TextEditingController.fromValue(
                TextEditingValue(text:condition,selection: TextSelection(baseOffset: condition.length, extentOffset: condition.length))
              ),
              onChanged: (value){
                setState(() {
                  condition=value;
                });
              },
              onEditingComplete:(){
                print("输入完成");
              },
            ),
            Container(
              height: 20,
              color: Color.fromRGBO(200,200,200, 0.2),
              margin: EdgeInsets.only(bottom: 20),
            ),
            GestureDetector(
              child: Container(
                width: 100,
                height: 40,
                color: Colors.blue,
                child: Center(child: Text("搜 索",style:TextStyle(color:Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),),
              ),
            )
          ],
        ),
      ),
      ),
    );
  }
}