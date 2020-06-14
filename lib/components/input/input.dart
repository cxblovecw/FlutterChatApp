import 'package:flutter/material.dart';
class Input extends StatefulWidget {
  String text="";            // 绑定外部的数据 
  String hintText;        // 提示文本
  IconData defaultIcon;   // 默认的图标
  Function setText;      // 回调函数 因为子widget无法操作外部的数据 所以从父widget传入回调函数进行操作
  bool isPassword;        // 是否是密码类型
  Function clearText;     // 清空文本 同上 子widget无法操作外部数据
  TextInputType inputType;
  Input(this.text,this.hintText,this.defaultIcon,this.isPassword,this.setText,this.clearText,{this.inputType});
  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input>{
  bool passwordVisible=false;
  bool showHintText=true;
  FocusNode fn=FocusNode();
  @override
  void initState() { 
    super.initState();
    fn.addListener(() {
      setState(() {
        if(fn.hasFocus){
        showHintText=false;
      }else{
        showHintText=true;
      }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.fromLTRB(0, 5,0, 5),  
            decoration: BoxDecoration(
              color: Color.fromRGBO(200,200,200,0.3),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              onTap: (){
                setState(() {
                  showHintText=false;
                });
              },
              autofocus: false,
              enableInteractiveSelection: false,
              focusNode: fn,
              controller: TextEditingController.fromValue(
                TextEditingValue(
                  text:widget.text,
                  selection: new TextSelection.fromPosition(TextPosition(
                    affinity: TextAffinity.upstream,offset: widget.text.length))
                    )
              ),
              obscureText: (!passwordVisible&&widget.isPassword),
              textAlign: TextAlign.center,
              keyboardType:widget.inputType??TextInputType.text,
              decoration: InputDecoration(
                hintText: showHintText? widget.hintText:"",
                prefixIcon: widget.isPassword?IconButton(
                  icon: Icon(passwordVisible?Icons.visibility:Icons.visibility_off,color: Colors.grey),
                  onPressed: (){
                    setState(() {
                      passwordVisible=!passwordVisible;
                    });
                  },
                ):Icon(widget.defaultIcon,color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(Icons.close,color: Colors.grey),
                  onPressed: widget.clearText
                ),
                border: InputBorder.none,
            ),
            onChanged: (value){
              print(value);
              setState(() {
                widget.setText(value);
              });
            },
          ),
        );
  }
}