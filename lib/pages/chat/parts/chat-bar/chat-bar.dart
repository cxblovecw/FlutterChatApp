part of '../../chat.dart';
class ChatBar extends StatefulWidget {
  @override
  _ChatBarState createState() => _ChatBarState();
}
// 存储聊天框的输入内容 放在外面是为了给其他文件访问
String inputText="";
// 输入框的控制器 
TextEditingController controller=new TextEditingController.fromValue(
  TextEditingValue(
    text:inputText,
    selection: new TextSelection.fromPosition(TextPosition(
      affinity: TextAffinity.downstream,offset: inputText.length)))
);

class _ChatBarState extends State<ChatBar> {
  // 控制聊天功能导航条的显示和隐藏
  bool offstage=true;
  // 输入框的行数
  int maxline=1;
  // 聊天功能栏 当前位置 0为置空，即都不显示，图标也不高亮
  int currentIndex=0;
  // 聊天功能栏对应的内容列表
  List<Widget> chatBarContent;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // 初始化底部功能栏
    chatBarContent=[
      Container(),
      ChatVoice(),
      Container(),
      Container(),
      ChatEmoji(),
      Container(),
    ];
    // 使用Warp做容器 因为其中的内容是动态的
    return Wrap(children: <Widget>[
        Row(
          children: <Widget>[
            // 输入框的外部包装
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 15,right: 10.0,top: 10,bottom: 0),
                padding: EdgeInsets.only(left: 15,right: 15.0,top: 0,bottom: 0),
                decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                // 输入框
                child:TextField(
                  controller: controller,
                  minLines: 1,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border:InputBorder.none,
                    contentPadding: EdgeInsets.all(5)   
                    ),
                    // 点击输入框时 底部的功能内容隐藏
                    onTap: (){
                      setState(() {
                        offstage=true;
                        currentIndex=0;
                      });
                    },
                ),
            ),
            ),
            // 发送按钮
            GestureDetector(
              onTap: (){
                print(controller.text);
                // 清空输入框
                controller.clear();
              },
              child: Container(
                height: 30,
                width: 50,
                margin: EdgeInsets.only(top: 12,right: 15),
                alignment: Alignment.center,
                child: Text("发送",style: TextStyle(color: Colors.white),),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15)
                ),
              ),
            ),
          ],
        ),
        // 聊天功能导航条
        Row(
          children: <Widget>[
            // 语音按钮
            Expanded(child: IconButton(icon: Icon(Icons.mic,color:currentIndex==1?Colors.blue:Colors.black54,), onPressed: (){
              showOrHide(1,context);
              print(Permission.microphone.status);
              Permission.microphone.status.isGranted.then((value) =>{
                if(value==false){
                  Permission.microphone.request().then((value) => {
                    print("请求权限")
                  })
                }else{
                    print("有权限")
                }
              });
              // if(){
              //   print("没有权限");
              // }else{
              //   print("有权限");
              // }
            }),flex: 1,),
            // 照片按钮
            Expanded(child: IconButton(icon: Icon(Icons.photo_size_select_actual,color:currentIndex==2?Colors.blue:Colors.black54,), onPressed: (){
              getImages().then((value) =>{
             
              });
              // showOrHide(2,context);
            }),flex: 1,),
            // 拍照按钮
            Expanded(child: IconButton(icon: Icon(Icons.camera_alt,color:currentIndex==3?Colors.blue:Colors.black54,), onPressed: (){
              openCamera();
              showOrHide(3,context);
            }),flex: 1,),
            // 表情按钮
            Expanded(child: IconButton(icon: Icon(Icons.tag_faces,color:currentIndex==4?Colors.blue:Colors.black54), onPressed: (){
              showOrHide(4,context);
            }),flex: 1,),
            // 文件按钮
            Expanded(child: IconButton(icon: Icon(Icons.folder_open,color:currentIndex==5?Colors.blue:Colors.black54), onPressed: (){
              showOrHide(5,context);
            }),flex: 1,),
          ],
        ),
        // 聊天功能导航条对应的内容部分
        Offstage(
          offstage: offstage,
          child:chatBarContent[currentIndex],
        ),
    ],
    );
  }
  // 控制功能内容部分隐藏和显示
  showOrHide(index,context){
    FocusScope.of(context).requestFocus(FocusNode());
    new Timer(new Duration(milliseconds: 200),(){
    setState(() {
      if(offstage==true){
        currentIndex=index;
        offstage=false;
      }else if(currentIndex!=index){
        currentIndex=index;
      }else{
        currentIndex=0;
        offstage=true;
      }
    });
   });
  }
}