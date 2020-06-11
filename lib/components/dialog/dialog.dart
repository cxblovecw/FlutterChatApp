import 'package:flutter/material.dart';
class MyDialog extends StatefulWidget {
  String title;
  String content;
  Function callback;
  bool hasCancel;
  MyDialog(this.title,this.content,{this.callback,this.hasCancel=false});
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)),
      title: Text(widget.title),
      content: Text(widget.content),
      actions: <Widget>[
        widget.hasCancel?FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child:Text("取消")):null,
        FlatButton(onPressed: (){
          Navigator.pop(context);
          if(widget.callback!=null){
            widget.callback();
          }
        }, child:Text("确定"))
      ],
    );
  }
}
