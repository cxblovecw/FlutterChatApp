part of '../../chat.dart';
class VideoCall extends StatefulWidget {
  Function closeCall;
  VideoCall(this.closeCall);
  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  // 是否静音
  bool isMute=false;
  // 麦克风是否可用
  bool noSpeaking=false;
  // 是否切换大小屏
  bool switchView=false;
  // 我的屏幕
  static Widget me;
  // 好友屏幕
  static Widget friend=Container();

  @override
  void initState() { 
    super.initState();
    // 获取我的屏幕
    me=AgoraRenderWidget(0, local: true, preview: true);
    // 好友连接时 获取好友的屏幕
    AgoraRtcEngine.onUserJoined = (int uid, int elapsed){
      setState(() {
        friend=AgoraRenderWidget(uid);
      });
    };
    AgoraRtcEngine.muteLocalAudioStream(isMute);
    AgoraRtcEngine.muteAllRemoteAudioStreams(noSpeaking);
    // 好友离开时 删除存放他屏幕的Widget
    AgoraRtcEngine.onUserOffline = (int uid, int reason){
      setState(() {
        friend=Container();
      });
    }; 
  }
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
      home:Scaffold(
        // backgroundColor: Colors.black26,
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // 全屏显示的屏幕
            Container(
              width: double.infinity,
              height: double.infinity,
              color:Colors.black26,
              child:Expanded(child: AnimatedSwitcher(duration: Duration(milliseconds:1500),
                child: switchView?friend:me)
              )),
            // 顶部按钮组
            Positioned(
              top: 30,left: 0,right: 0,
              child: Container(
                 child:Row(  
                  children: <Widget>[
                    // 最小化按钮
                    IconButton(icon:Icon(Icons.settings_overscan,color: Colors.white),onPressed:() {
                      Navigator.of(context).pop();
                    }),
                    Expanded(child: Container()),
                    // 切换前后摄像头
                    IconButton(icon:Icon(Icons.camera_alt,color: Colors.white), onPressed:(){
                      AgoraRtcEngine.switchCamera();
                    }),
                  ],
              ) 
              ),
            ),
            //  小屏显示屏幕
            Positioned(
              top: 85,
              right: 5,
              child: Container(
              width: 120,
              height: 180,
              child: AnimatedSwitcher(duration:Duration(seconds: 1),
                child: switchView?me:friend,
              )
              ),
            ),
            // 包含插件返回的Widget不知道为啥事件没法触发 因此使用这个透明遮罩触发事件
            Positioned(
              top: 85,
              right: 5,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    switchView=!switchView;
                  });
                },
                child: Container(
                color: Colors.transparent,
                width: 120,
                height: 180,
                child: Container()),
              )
            ),
            // 顶部按钮组
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child:Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30,20),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   // 控制麦是否打开
                   Container(
                    alignment: Alignment.center,
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: noSpeaking?Colors.blue:Colors.black26,
                      borderRadius: BorderRadius.circular(35)
                    ),
                    child:IconButton(icon: Icon(noSpeaking?Icons.mic_off:Icons.mic,color:Colors.white), onPressed:(){
                      setState(() {
                        noSpeaking=!noSpeaking;  
                      });
                      AgoraRtcEngine.muteLocalAudioStream(noSpeaking);
                  }),),
                  // 关闭通话
                   Container(
                    height: 70,
                    width: 70,
                    margin: EdgeInsets.only(left: 25,right: 25),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(35)
                    ),
                    child:IconButton(icon: Icon(Icons.local_phone,color: Colors.white), onPressed: (){
                      // 离开频道
                      AgoraRtcEngine.leaveChannel();
                      // 销毁AgoraRtcEngine实例对象
                      AgoraRtcEngine.destroy();
                      // 传递进来的方法 目的是控制最小化之后的浮动按钮的显示 但是在这里控制不了外部的state 将方法传递进来 然后调用即可控制
                      widget.closeCall();
                      Navigator.of(context).pop();
                  }),),
                  //  是否静音
                   Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: isMute?Colors.blue:Colors.black26,
                      borderRadius: BorderRadius.circular(35)
                    ),
                    child:IconButton(icon: Icon(isMute?Icons.volume_off:Icons.volume_up,color:Colors.white), onPressed: (){
                      setState(() {
                        isMute=!isMute;
                      });
                      AgoraRtcEngine.muteAllRemoteAudioStreams(isMute);
                  })),
                ],
              ),
              ))
          ],
        ),
    ));
  }
}