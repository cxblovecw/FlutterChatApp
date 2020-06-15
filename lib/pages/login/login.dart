import 'package:FlutterStudy/components/dialog/dialog.dart';
import 'package:FlutterStudy/components/input/input.dart';
import 'package:FlutterStudy/pages/register/register.dart';
import 'package:FlutterStudy/tabs.dart';
import 'package:FlutterStudy/utils/DioRequest.dart';
import 'package:FlutterStudy/utils/storage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AutomaticKeepAliveClientMixin{
  String account="";
  String password="";
  bool passwordVisible=false;
  @override
  bool get wantKeepAlive=>true;
  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child:Scaffold(
      body: Container(
      padding: EdgeInsets.fromLTRB(40, 80, 40, 0),
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
            Icon(Icons.android,size: 50,color: Colors.green,),
            Container(width: 10),
            Text("Login",textAlign: TextAlign.center,style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold)),
          ],),
          Container(height: 50,),
          Input(account,"请输入账号",Icons.person_outline,false,(value){
            setState(() {
              account=value;
            });
          },(){
            setState(() {
              account="";
            });
          },inputType: TextInputType.number,),
          Container(height: 20,),
          Input(password,"密码",Icons.visibility_off,true,(value){
            setState(() {
              password=value;
            });
          },(){
            setState(() {
              password="";
            });
          }),
          // Container(
          //   padding: EdgeInsets.fromLTRB(0, 5,0, 5),  
          //   decoration: BoxDecoration(
          //     color: Color.fromRGBO(200,200,200,0.3),
          //     borderRadius: BorderRadius.circular(30),
          //   ),
          //   child: TextField(
          //     autofocus: false,
          //     enableInteractiveSelection: false,
          //     controller: TextEditingController.fromValue(
          //       TextEditingValue(
          //         text:account,
          //         selection: new TextSelection.fromPosition(TextPosition(
          //           affinity: TextAffinity.downstream,offset: account.length)))
          //     ),
          //     textAlign: TextAlign.center,
          //     keyboardType: TextInputType.number,
          //     decoration: InputDecoration(
          //       hintText: "请输入账号",
          //       prefixIcon: Icon(Icons.person,color: Colors.grey),
          //       suffixIcon: IconButton(
          //         icon: Icon(Icons.close,color: Colors.grey),
          //         onPressed: (){
          //           setState(() {
          //             account="";
          //           });
          //         },
          //       ),
          //       border: InputBorder.none,
          //   ),
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
          //     enableInteractiveSelection: false,
          //     autofocus: false,
          //     obscureText: !passwordVisible,
          //     controller: TextEditingController.fromValue(
          //       TextEditingValue(
          //         text:password,
          //         selection: new TextSelection.fromPosition(TextPosition(
          //           affinity: TextAffinity.downstream,offset: password.length)))
          //     ),
          //     textAlign: TextAlign.center,
          //     keyboardType: TextInputType.text,
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
          //   onTap: (){

          //   },
          // ),
          // ),
          Container(height: 30),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color:(account.length!=0&&password.length!=0)?Colors.blue:Colors.grey,
            ),
            child: IconButton(icon: Icon(Icons.arrow_forward,color: Colors.white), onPressed:(account.length!=0&&password.length!=0)?(){
              request.get("/login",queryParameters: {
                "account":account,
                "password":password
              }).then((value) =>{
                print(value.data),
                if(value.data=='noAccount'){
                  showDialog(context: context,builder: (context){
                    return MyDialog("登录失败","账号不存在");
                  }),
                  setState((){
                    password="";
                  }),
                  }else if(value.data=='passwordError'){
                    showDialog(context: context,builder: (context){
                      return MyDialog("登录失败","密码错误,请重新输入");
                    }).whenComplete(() => {
                      setState((){
                        password="";
                      }),
                    })}else if(value.data=='error'){
                      showDialog(context: context,builder: (context){
                        return MyDialog("登录失败","服务器错误,请检查网络");
                      })
                    }else{
                      print(value.data),
                      setStorage("account",value.data.toString()),
                      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(context){
                        return Tabs();
                      }),(route)=>route==null)
                    }
              });
              
            }:null),
          ),
          Expanded(child: Container()),
          Row(
            children: <Widget>[
              Expanded(child:Container(
                child: Text("忘记密码",textAlign: TextAlign.center),
              )),
              Text("|"),
              Expanded(child:GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return RegisterPage();
                  }));
                },
                child:Container(
                child: Text("用户注册",textAlign: TextAlign.center),
              )
              )),
            ],
          ),
          Container(height: 18,)
       ],
     ), 
    ),
    )
    );
  }
}