import 'package:FlutterStudy/utils/storage.dart';
import 'package:flutter/material.dart';

class MyQrCode extends StatefulWidget {
  @override
  _MyQrCodeState createState() => _MyQrCodeState();
}

class _MyQrCodeState extends State<MyQrCode> {
  dynamic userInfo;
  @override
  void initState() { 
    super.initState();
    initStateSync();
  }
  initStateSync()async{
    userInfo=await getStorage("userInfo");
    print(userInfo);
  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("我的二维码"),
        centerTitle: true,
        leading: BackButton(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 80),
        child: Card(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
            child: Column(
              children: <Widget>[
                Row(
                    children: <Widget>[
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: userInfo!=null?Image(image:NetworkImage(userInfo['avatarUrl'])):null, 
                      //  child: Image(image:NetworkImage("http://192.168.1.12:4200/project/images/avatars/avatar14.jpg")),  
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: userInfo!=null?[
                          Text(userInfo['userName'],style: TextStyle(fontSize: 18),),
                          Container(height:15),
                          Text("性别:"+userInfo['sex']+"   年龄:"+userInfo['age'].toString(),style: TextStyle(fontSize: 14,color:Colors.black38),)
                        ]:[],
                      )
                    ],
                ),
                Container(
                  width: width*0.8,
                  height: width*0.8,
                  decoration: BoxDecoration(
                    image:userInfo!=null?DecorationImage(image: NetworkImage(userInfo['qrCodeUrl'],scale: 0.8)):null
                    //  image:DecorationImage(image: NetworkImage("http://192.168.1.12:4200/users/10001/qrcode.png"))
                  ),
                ),
                Text("扫一扫上方的二维码图案，添加好友")
              ],
            ),
          ),
        ),
      ),
    );
  }
}