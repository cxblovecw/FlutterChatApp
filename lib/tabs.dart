import 'package:FlutterStudy/pages/chat/chat.dart';
import 'package:FlutterStudy/pages/chat/parts/chat-vioce-call/chat-voice.dart';
import 'package:flutter/material.dart';
import 'package:FlutterStudy/pages/drawer/drawer.dart';
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
  // 控制底部导航
  int index=0;
  closeCall(){
    setState(() {
      ChatPage.isCalling=false;
      ChatPage.type=null;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("$title"),
        centerTitle: true,
        // AppBar中的头像
        leading: Leading(),
        actions: <Widget>[
          // 弹出菜单按钮 Offset>100 会出现在AppBar下
          PopupMenuButton(
            offset: Offset(180,120),
            icon: Icon(Icons.add),
            shape: RoundedRectangleBorder(),
            itemBuilder: (BuildContext context){
              // 弹出菜单
              return <PopupMenuItem>[
                PopupMenuItem(child: Text("加好友/群")),  
                PopupMenuItem(child: Text("加好友/群")),
                PopupMenuItem(child: Text("加好友/群")),
                PopupMenuItem(child: Text("加好友/群")),
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
    );
  }
}

class Leading extends StatelessWidget {
  // AppBar头像按钮 点击打开抽屉
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon:CircleAvatar(
          backgroundImage: NetworkImage("https://c-ssl.duitang.com/uploads/item/201803/19/20180319132911_UxCLe.jpeg"),
        ), 
        onPressed:(){
          Scaffold.of(context).openDrawer();
        }
      );
  }
}