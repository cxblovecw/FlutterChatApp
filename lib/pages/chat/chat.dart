// import 'package:FlutterStudy/pages/chat/parts/chat-vioce-call/chat-voice.dart';
import 'package:FlutterStudy/pages/chat/parts/chat-vioce-call/chat-voice.dart';
import 'package:FlutterStudy/tabs.dart';
import 'package:FlutterStudy/utils/AppID.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

part 'package:FlutterStudy/pages/chat/parts/chat-bar/chat-bar.dart';
part 'package:FlutterStudy/pages/chat/parts/chat-video-call/chat-video.dart';
part 'package:FlutterStudy/pages/chat/parts/chat-bar-content/chat-camera.dart';
part "package:FlutterStudy/pages/chat/parts/chat-bar-content/chat-emoji.dart";
part "package:FlutterStudy/pages/chat/parts/chat-bar-content/chat-image.dart";
part "package:FlutterStudy/pages/chat/parts/chat-bar-content/chat-voice.dart";

enum MediaType{
  Voice,Video
}

class ChatPage extends StatefulWidget {
  final String name;
  static MediaType type;
  static bool isCalling=false;
  ChatPage(this.name);
  @override
  _ChatPageState createState() => _ChatPageState();
}



class _ChatPageState extends State<ChatPage> {
  // 是否通话中 用于控制最小化时 浮动按钮的显示 
  @override
  void initState() { 
    super.initState();
  }
  // 将此方法传递给子widget 赋予子widget控制父widget的state的能力
  closeCall(){
    setState(() {
      ChatPage.isCalling=false;
      ChatPage.type=null;
    });
  }
  toVideo()async{
    print(ChatPage.type);
    print(ChatPage.isCalling);
    if(ChatPage.type==MediaType.Video&&ChatPage.isCalling){
      print("跳转");
      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context){
      return VideoCall(closeCall);
      }));
    }
    if(ChatPage.type==MediaType.Voice&&ChatPage.isCalling){
      print("正在通话中");
    }
    if(ChatPage.type==null){
    // 创建实例
    await AgoraRtcEngine.create(APP_ID);
    // 启用视频模块
    await AgoraRtcEngine.enableVideo();
    // 启用音频模块
    await AgoraRtcEngine.enableAudio();
    // 加入频道
    await AgoraRtcEngine.joinChannel(null, '110', null,0).then((value) => {
      setState((){
        ChatPage.isCalling=true;
        ChatPage.type=MediaType.Video;
      })
    });
    Navigator.push(context,MaterialPageRoute(builder: (BuildContext context){
      return VideoCall(closeCall);
    }));
    }
  }
  toVoiceCall()async{
    if(ChatPage.type==MediaType.Voice&&ChatPage.isCalling){
        print("跳转");
        Navigator.push(context,MaterialPageRoute(builder: (BuildContext context){
          return VoiceCall(closeCall);
    }));
    }
    if(ChatPage.type==MediaType.Video&&ChatPage.isCalling){
      print("正在通话");
    }
    if(!ChatPage.isCalling){
      // 创建实例
      await AgoraRtcEngine.create(APP_ID);
      // 启用音频模块
      await AgoraRtcEngine.enableAudio();
      // 加入频道
      await AgoraRtcEngine.joinChannel(null, '220', null,0).then((value) => {
        setState((){
          ChatPage.isCalling=true;
          ChatPage.type=MediaType.Voice;
        })
      });
      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context){
      return VoiceCall(closeCall);
    }));
    }
  }
  // 清除TextField的焦点
  clearFocus(){
    FocusScope.of(context).requestFocus(new FocusNode());
  }
  @override
  Widget build(BuildContext context) {
    // 在Scaffold外部包裹GestureDetector 用于点击消除TextField焦点
    return GestureDetector(
      onTap: (){clearFocus();},
      child:Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black,),
        // 左侧返回按钮
        leading: IconButton(icon: Icon(Icons.chevron_left,color: Colors.black,size: 25.0,), onPressed:(){
          Navigator.pushReplacement(context,MaterialPageRoute(
            builder: (context){
              return Tabs();
            }
          ));
        }),
        title:Text("${widget.name}",style: TextStyle(color: Colors.black,fontSize: 16.0,fontWeight: FontWeight.w600),),
        // 右侧按钮
        actions: <Widget>[
          // 点击 底部出现模态菜单
          IconButton(icon: Icon(Icons.phone), onPressed: (){
            clearFocus();
            // 底部模态框
            showModalBottomSheet(context: context, builder:(context){
              return Container(
                decoration: BoxDecoration(
                ),
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                      title: Text("语音通话",textAlign: TextAlign.center,),
                      onTap: ()async{
                        await Permission.microphone.request();
                        // 隐藏模态框
                        Navigator.pop(context);
                        // 跳转至语音页面
                        toVoiceCall();
                      },
                    ),
                    ListTile(
                      title: Text("视频通话",textAlign: TextAlign.center,),
                      onTap: ()async{
                        await [
                          Permission.microphone,
                          Permission.camera
                        ].request();
                        // 隐藏模态框
                        Navigator.pop(context);
                        toVideo();
                      }
                    )
                  ],
               ),
              );
            });
          }),
          IconButton(icon: Icon(Icons.menu), onPressed: (){
            clearFocus();
          }),
        ],
      ),
      body:Column(
      children: <Widget>[
        Expanded(
        child: Stack(children: <Widget>[
          ListView(
            children: <Widget>[
              Container(height: 900,color:Colors.red),
              Container(height: 900,color:Colors.blue),
              Text("结束")
            ],
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: ChatPage.isCalling?Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color:Colors.blue,
                borderRadius: BorderRadius.circular(27)
              ),
              child: IconButton(icon: Icon(Icons.phone_in_talk,color: Colors.white,),onPressed: (){
                if(ChatPage.type==MediaType.Voice){
                  toVoiceCall();
                }
                if(ChatPage.type==MediaType.Video){
                  toVideo();
                }
              }),
             ):Container()),
        ],)),
        Container(
            color:Color.fromRGBO(220, 220, 220,0.2),
            child: ChatBar(),
        )
      ],
    )
    )
    );
  }
}
