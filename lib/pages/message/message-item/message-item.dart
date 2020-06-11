import 'package:FlutterStudy/pages/chat/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MessageItem extends StatefulWidget {
  final String avatar;
  // "https://c-ssl.duitang.com/uploads/item/201803/19/20180319132911_UxCLe.jpeg"
  final String title;
  final String content;
  final String time;
  MessageItem(this.avatar,this.title,this.content,this.time);
  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    // Slidable为插件提供 实现左右滑动出现按钮
    return Slidable(
      child: GestureDetector(
        child: Container(
          color: Colors.green,
          height:75.0,
          child: Row(
            children:[
              Container(
                margin: EdgeInsets.only(left:20.0,right: 20.0),
                width: 45.0,
                height: 45.0,
                child: CircleAvatar(
                backgroundImage: NetworkImage(widget.avatar),
              )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Text(widget.title,style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w600,fontFamily: "楷体"),),
                      Expanded(child: Text(""),),
                      Text(widget.time,style: TextStyle(fontSize: 13.0,color: Colors.black54)),
                    ],),
                    Container(height: 5.0),
                    Text(widget.content,style: TextStyle(fontSize: 13.0,color: Colors.black54),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  ],
              )),
              Container(width:20)
            ]
          ),
        ),
        onTap: (){
          Navigator.of(context).push(
            CupertinoPageRoute(builder:(BuildContext context){
              return ChatPage("张三");
            }));
        },
      ), 
      // 默认就这样写
      actionPane: SlidableDrawerActionPane(),
      // 出现的按钮列表
      secondaryActions:<Widget>[
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.delete,
          onTap: (){
            print("删除");
          },
        ),
        IconSlideAction(
          caption: '置顶',
          color: Colors.indigo,
          icon: Icons.arrow_drop_up,
          onTap: (){
            print("置顶");
          },
        ),
      ],
    );
  }
}