import 'package:FlutterStudy/pages/chat/chat.dart';
import 'package:FlutterStudy/pages/chat/parts/chat-vioce-call/chat-voice.dart';
import 'package:FlutterStudy/pages/friend/searchFriend/searchFriend.dart';
import 'package:FlutterStudy/utils/DioRequest.dart';
import 'package:FlutterStudy/pages/info/info.dart';
import 'package:FlutterStudy/utils/storage.dart';
import "package:barcode_scan/barcode_scan.dart";
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:FlutterStudy/pages/drawer/drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:FlutterStudy/pages/message/message.dart';
import 'package:FlutterStudy/pages/contact/contact.dart';
import 'package:FlutterStudy/pages/moments/moments.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  // 控制顶AppBar的title
  String title="消息";
  dynamic userInfo;
  // 控制底部导航
  int index=0;
  DateTime lastPopTime;
  @override
  void initState() { 
    super.initState();
    initStateSync();
  }
  initStateSync()async{
    userInfo=await getUserInfo((await getStorage("account")).toString());
    lastPopTime=null;
    print(userInfo);
    setStorage("userInfo",'${userInfo.toString()}');
    // setStorage("age",userInfo.data["age"]);
    // setStorage("sex", userInfo.data["sex"]);
    // setStorage("qrCodeUrl", userInfo.data['qrCodeUrl']);
    // setStorage("avatarUrl", userInfo.data["avatarUrl"]);
    // setState((){
    //   avatarUrl=userInfo.data["avatarUrl"];
    // });
  }
  closeCall(){
    setState(() {
      ChatPage.isCalling=false;
      ChatPage.type=null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(
        title:Text("$title"),
        centerTitle: true,
        // AppBar中的头像
        leading: Leading(userInfo!=null?userInfo.data:{}),
        actions: <Widget>[
          // 弹出菜单按钮 Offset>100 会出现在AppBar下
          PopupMenuButton(
            padding: EdgeInsets.all(0),
            offset: Offset(180,120),
            icon: Icon(Icons.add),
            shape: RoundedRectangleBorder(),
            onSelected: (value)async{
              if(value==1){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return SearchFriend();
                }));
              }
              if(value==2){
                var result=await BarcodeScanner.scan(options:ScanOptions(
                  strings: {"cancel":"取消","flash_on":"打开手电","flash_off":"关闭手电"},
                  autoEnableFlash: false,
                  android: AndroidOptions(
                  )
                ));
                var account=JsonDecoder().convert(result.rawContent)['account'].toString();
                Navigator.pushReplacement(context,MaterialPageRoute(
                  builder: (context) {
                    return Info(account:account);
                  },
                ));
              }
            },
            onCanceled: (){
              print("取消");
            },
            itemBuilder: (BuildContext context){
              // 弹出菜单
              return [
                PopupMenuItem(
                  value: 1,
                  child: Row(children: <Widget>[
                 Icon(Icons.person,color: Colors.grey,),Container(width: 10,), Text("加好友/群")
                ],)),
                PopupMenuItem(
                  value: 2,
                  child:Row(
                    children: <Widget>[
                  Icon(Icons.crop_free,color: Colors.grey,),Container(width: 10,),Text("扫一扫"),
                ]),
                )
            ];
          })
        ],
      ),
      // 抽屉菜单
      drawer: MyDrawer(),
      // body:tabsList[index],
      // 底部导航对应的内容
      body: IndexedStack(
        index: index,
        children:[
          MessagePage(),
          ContactPage(),
          MomontsPage(),]
      ),
      floatingActionButton: ChatPage.isCalling?Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color:Colors.blue
        ),
        child:IconButton(icon: Icon(Icons.phone_in_talk,color:Colors.white), onPressed:(){
        if(ChatPage.type==MediaType.Video){
          Navigator.push(context,MaterialPageRoute(builder: (BuildContext context){
          return VideoCall(closeCall);
        }));
        }
        if(ChatPage.type==MediaType.Voice){
          Navigator.push(context,MaterialPageRoute(builder: (BuildContext context){
          return VoiceCall(closeCall);
        }));
        }
      })
      ):null,
      // 底部导航
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.message),title:Text("消息")),
          BottomNavigationBarItem(icon: Icon(Icons.people),title:Text("联系人")),
          BottomNavigationBarItem(icon: Icon(Icons.polymer),title:Text("动态")),
        ],
        // 点击时切换标题和内容
        onTap: (value){
          setState(() {
            if(value==0){title="消息";}
            else if(value==1){title="联系人";}
            else{title="动态";}
            index=value;
          });
        },
        currentIndex: index
        ),
    ), onWillPop: ()async{
      print(lastPopTime);
      print(DateTime.now());
       if(lastPopTime!=null&&DateTime.now().difference(lastPopTime)<Duration(milliseconds: 1500)){
         SystemNavigator.pop();
       }else{
         Fluttertoast.showToast(msg: "再按一次退出程序");
       }
       setState(() {
           lastPopTime=DateTime.now();
         });
    });
  }
}

class Leading extends StatelessWidget {
  dynamic userInfo;
  Leading(this.userInfo);
  // AppBar头像按钮 点击打开抽屉
  @override
  Widget build(BuildContext context){
    return IconButton(
        icon:CircleAvatar(
          backgroundImage:userInfo['avatarUrl']!=null?NetworkImage(userInfo['avatarUrl']):null,
        ), 
        onPressed:(){
          Scaffold.of(context).openDrawer();
        }
      );
  }
}