part of '../../chat.dart';

class ChatVoice extends StatefulWidget {
  @override
  _ChatVoiceState createState() => _ChatVoiceState();
}

class _ChatVoiceState extends State<ChatVoice> {
  // 两边按钮的透明度
  double opacity=0;
  // 当前hint的下表 用于切换提示
  int currentIndex=0;
  // 提示列表 即按钮上方的文字提示
  List<String> hint=[
    "按住说话",
    "正在说话",
    "松手转文字",
    "松手取消发送",
  ];
  // 执行什么操作
  String operation='';
  // 语音转文字的按钮颜色
  Color voiceToTxt=Colors.black12;
  // 取消发送的按钮颜色
  Color cancel=Colors.black12;
  // 
  FlutterSoundRecorder rs;
  @override
  Widget build(BuildContext context){
    // 获取屏幕宽高
     double width=MediaQuery.of(context).size.width;
     double height=MediaQuery.of(context).size.height;
     return Container(
      // 大致和输入法一样高的高度
      height: MediaQuery.of(context).size.height*0.36,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Opacity(
              child: Container(
                height: 60.0,
                width: 60.0,
                margin: EdgeInsets.fromLTRB(width/6-30, 0, width/6-30, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  // voiceToTxt用于控制按钮的颜色
                  color: voiceToTxt,
                ),
                child: IconButton(icon: Icon(Icons.translate),onPressed: (){}),
             // 根据opacity的值控制按钮的显示
            ),opacity: opacity)
          ),
          Expanded(
            child: Container(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // 提示信息 根据currentIndex而改变
                  Text(hint[currentIndex],),
                  Container(height:height*0.18-60),
                  GestureDetector(
                    // 录音按钮长按事件
                    onLongPress: () async {
                      print("开始录音");
                      // 实例化 
                      rs=FlutterSoundRecorder();
                      // 使用path_provider插件获取路径
                      getExternalStorageDirectory().then((value) => {
                        // 开始录音 
                        rs.startRecorder(uri: value.path+"/ttt.mp3")
                      });
                      setState(() {
                        opacity=1;
                        currentIndex=1;
                      }); 
                    },
                    // 录音按钮移动事件
                    // 注意：移动时候左边位置 是从按钮的左边开始的
                    onLongPressMoveUpdate: (value){
                      // print(operation);
                      var offset=value.localPosition;
                      // 移动到左边的 语音转文字按钮
                      if((offset.dx>((-width/2)+70))&&(offset.dx<(-width/6+30))&&(offset.dy>15)&&(offset.dy<70)){
                        setState(() {
                          // print("语音转文字");
                          currentIndex=2;
                          voiceToTxt=Colors.green;
                          operation="voiceToTxt";
                        });
                      }
                      // 移动到右边的取消按钮
                      else if((offset.dy>15)&&(offset.dy<70)&&(offset.dx>50+width/6)&&(offset.dx<width/3+50)){
                        // print("取消发送");
                        setState(() {
                          currentIndex=3;
                          cancel=Colors.red;
                          operation="cancel";
                        });
                        // 长按状态 但不在两侧任意一个按钮范围内
                      }else{
                        operation="";
                        setState(() {
                          currentIndex=1;
                          voiceToTxt=Colors.black12;
                          cancel=Colors.black12;
                        });
                      }
                    },
                    // 录音按钮结束事件
                    onLongPressEnd: (value){
                      if(operation=="cancel"){
                        // 取消录音
                        rs.release();
                        print("取消");
                      }else if(operation=='voiceToTxt'){
                        print("语音转文字");
                      }else{
                        print("发送语音");
                        // 结束录音
                        rs.stopRecorder();
                        // print(rs.tmpUri);
                        // print(rs.tmpUri);
                        // print(rs.savedUri);
                      }
                      setState(() {
                        opacity=0;
                        currentIndex=0;
                        voiceToTxt=Colors.black26;
                      });
                    },
                    child:Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color:Colors.black12
                    ),
                    child:Icon(Icons.mic),
                    )
                  ),
                
                ],
            )
            )
          ),
          Expanded(
            child: Opacity(
              child: Container(
                height: 60.0,
                width: 60.0,
                margin: EdgeInsets.fromLTRB(width/6-30, 0, width/6-30, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  // cancel 用于控制按钮的颜色
                  color: cancel,
                ),
                child: IconButton(icon: Icon(Icons.delete),onPressed: (){}),
              // 根据opacity的值控制按钮的显示
            ),opacity: opacity)
          )
        ],
      ),
    );
  }
  inVoiceToTxt(){

  }
  inCancel(){

  }
}