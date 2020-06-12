
import 'package:FlutterStudy/components/input/input.dart';
import 'package:FlutterStudy/tabs.dart';
import 'package:FlutterStudy/components/dialog/dialog.dart';
import 'package:FlutterStudy/utils/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:FlutterStudy/utils/DioRequest.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String phone="";
  String password="";
  String userName="";
  bool passwordVisible=false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
      body: Wrap(children: <Widget>[
        Container(height: 20,),
        Row(
          children:<Widget>[
            IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
            Navigator.pop(context);
            },)]
          ,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(40, 50, 40, 0),
          child: Column(
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                Icon(Icons.android,size: 50,color: Colors.green,),
                Container(width: 10),
                Text("Register",textAlign: TextAlign.center,style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold)),
              ],),
              Container(height: 50,),
              Input(phone,"手机号码",Icons.phone_android,false,(value){
                setState(() {
                  phone=value;
                });
              },(){
                setState(() {
                  phone="";
                });
              },inputType: TextInputType.number,),
              Container(height: 20,),
              Input(userName,"用户名",Icons.person_outline, false,(value){
                setState(() {
                  userName=value;
                });
              }, (){
                setState(() {
                  userName="";
                });
              }),
              Container(height: 20,),
              Input(password,"密码",Icons.person_outline,true,(value){
                setState(() {
                  password=value;
                });
              }, (){
                setState(() {
                  password="";
                });
              }),
          //     Container(
          //   padding: EdgeInsets.fromLTRB(0, 5,0, 5),  
          //   decoration: BoxDecoration(
          //     color: Color.fromRGBO(200,200,200,0.3),
          //     borderRadius: BorderRadius.circular(30),
          //   ),
          //   child: TextField(
          //     enableInteractiveSelection: false,
          //     controller: TextEditingController.fromValue(
          //       TextEditingValue(
          //         text:phone,
          //         selection: new TextSelection.fromPosition(TextPosition(
          //           affinity: TextAffinity.downstream,offset: phone.length)))
          //     ),
          //     textAlign: TextAlign.center,
          //     keyboardType: TextInputType.number,
          //     decoration: InputDecoration(
          //       hintText: "手机号码",
          //       prefixIcon: Icon(Icons.phone,color: Colors.grey),
          //       suffixIcon: IconButton(
          //         icon: Icon(Icons.close,color: Colors.grey),
          //         onPressed: (){
          //           setState(() {
          //             phone="";
          //           });
          //         },
          //       ),
          //       border: InputBorder.none,
          //   ),
          //   onChanged: (value){
          //     setState(() {
          //       phone=value;
          //     });
          //   },
          // ),
          // ),
          //    Container(
          //   margin: EdgeInsets.only(top: 20),
          //   padding: EdgeInsets.fromLTRB(0, 5,0, 5),
          //   decoration: BoxDecoration(
          //     color: Color.fromRGBO(200,200,200,0.3),
          //     borderRadius: BorderRadius.circular(30),
          //   ),
          //   child: TextField(
          //     obscureText: !passwordVisible,
          //     enableInteractiveSelection: false,
          //     controller: TextEditingController.fromValue(
          //       TextEditingValue(
          //         text:userName,
          //         selection: new TextSelection.fromPosition(TextPosition(
          //           affinity: TextAffinity.downstream,offset: userName.length)))
          //     ),
          //     textAlign: TextAlign.center,
          //     keyboardType: TextInputType.number,
          //     decoration: InputDecoration(
          //       hintText: "用户名",
          //       prefixIcon: IconButton(
          //         icon: Icon(Icons.person_outline,color: Colors.grey),
          //         onPressed: (){
                    
          //         },
          //       ),
          //       suffixIcon: IconButton(
          //         icon: Icon(Icons.close,color: Colors.grey),
          //         onPressed: (){
          //           setState(() {
          //             userName="";
          //           });
          //         },
          //       ),
          //       border: InputBorder.none,
          //   ),
          //   onChanged: (value){
          //     setState(() {
          //       userName=value;
          //     });
          //   },
          // ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(top: 20),
          //   padding: EdgeInsets.fromLTRB(0, 5,0, 5),
          //   decoration: BoxDecoration(
          //     color: Color.fromRGBO(200,200,200,0.3),
          //     borderRadius: BorderRadius.circular(30),
          //   ),
          //   child: TextField(
          //     obscureText: !passwordVisible,
          //     enableInteractiveSelection: false,
          //     controller: TextEditingController.fromValue(
          //       TextEditingValue(
          //         text:password,
          //         selection: new TextSelection.fromPosition(TextPosition(
          //           affinity: TextAffinity.downstream,offset: password.length)))
          //     ),
          //     textAlign: TextAlign.center,
          //     keyboardType: TextInputType.number,
          //     decoration: InputDecoration(
          //       hintText: "密码",
          //       prefixIcon: IconButton(
          //         icon: Icon(passwordVisible?Icons.visibility:Icons.visibility_off,color: Colors.grey),
          //         onPressed: (){
          //           setState(() {
          //             passwordVisible=!passwordVisible;
          //           });
          //         },
          //       ),
          //       suffixIcon: IconButton(
          //         icon: Icon(Icons.close,color: Colors.grey),
          //         onPressed: (){
          //           setState(() {
          //             password="";
          //           });
          //         },
          //       ),
          //       border: InputBorder.none,
          //   ),
          //   onChanged: (value){
          //     setState(() {
          //       password=value;
          //     });
          //   },
          // ),
          // ),
          Container(height: 30,),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color:(phone.length!=0&&password.length!=0)?Colors.blue:Colors.grey,
            ),
            child: IconButton(icon: Icon(Icons.arrow_forward,color: Colors.white), onPressed: (phone.length!=0&&password.length!=0)?(){
              if(RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$').hasMatch(phone)){
                  if(RegExp(r"[0-9]").hasMatch(password)&&RegExp(r"[A-Za-z]").hasMatch(password)&&password.length<=16&&password.length>=8){
                    if(userName.length==0){
                      showDialog(context: context,builder: (context){
                      return MyDialog("注册失败","用户名不得为空");
                    });
                    return;
                    }                    
                    request.get('/register',queryParameters: {
                      "phone":phone,
                      "password":password,
                      "userName":userName
                    }).then((value) =>{
                      if(value.data=='registered'){
                        showDialog(context: context,builder: (context){
                         return MyDialog("注册失败","手机号码已被注册");
                        })
                      }else{
                        print(value.data.runtimeType),
                        showDialog(context: context,builder: (context){
                        return  MyDialog("注册成功","即将跳转页面",callback:(){
                          setStorage("account", value.data);
                          print(value.data);
                          Navigator.push(context,MaterialPageRoute(builder: (BuildContext context){
                            return Tabs();
                          }));
                        });
                        })
                      }
                    });
                  }else{
                    showDialog(context: context,builder: (context){
                      return MyDialog("注册失败","密码不合法");
                    }).whenComplete(() =>setState(() {
                      password="";
                    }));
                  }
              }else{
                  showDialog(context: context,builder: (context){
                    return MyDialog("注册失败","手机号码不合法");
                  }).whenComplete(() => {setState(() {
                    phone="";
                  })});
                  print("注册失败 手机号码不合法");
              }
            }:null),
          ),
       ],
     ), 
    )
      ],),
    ),
    );
  }
}