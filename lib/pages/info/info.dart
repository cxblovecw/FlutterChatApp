import 'package:FlutterStudy/pages/chat/chat.dart';
import 'package:FlutterStudy/tabs.dart';
import 'package:FlutterStudy/utils/DioRequest.dart';
import 'package:FlutterStudy/utils/storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter/material.dart';
class Info extends StatefulWidget {
  String account;
  Info({this.account});
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool isMine=true;
  bool isFriend=true;
  dynamic userInfo;
  String age="";
  String userName="";
  String sex="";
  List sexList=["男","女","保密"];
  bool loaded=false;
  FocusNode ageFn=FocusNode();
  FocusNode userNameFn=FocusNode();
  @override
  void initState() { 
    super.initState();
    // 监听年龄输入框焦点事件
    ageFn.addListener(()async {
      if (!ageFn.hasFocus) {
        var primaryAge=userInfo['age'];
        if(age==""){
          print("age为空 并且失去焦点");
          setState(() {
            age=primaryAge.toString();
          });
        }
        updateUserInfo();
      }
    });
    // 监听用户名输入框焦点事件
    userNameFn.addListener(() {
      if (!userNameFn.hasFocus) {
        updateUserInfo();
      }
    });
    getUserInfoSync().then((result)=>{
      loaded=userInfo!=null,
      age=userInfo["age"]!=null?userInfo["age"].toString():"18",
      userName=loaded?userInfo["userName"]:"",
      sex=loaded?userInfo["sex"]:"",
    });
  }
  getUserInfoSync()async{
    var user=(await getUserInfo(widget.account)).data;
    var storageAccount=await getStorage("account");
    setState(() {
        userInfo=user;
        print(user['account'].runtimeType);
        print(storageAccount.runtimeType);
        isMine=user['account'].toString()==storageAccount.toString();
    });
    // if(isMine){
    //   user=await getStorage("userInfo");
    //   setState(() {
    //     userInfo=user;
    //   });
    // }
    // else{
    //   user=await getUserInfo(widget.account);
    //   print(user);
    //   setState(() {
    //     userInfo=user;
    //   });
    // }
  }
  updateUserInfo()async{
    request.get("/updateUserInfo",queryParameters: {
      "account":await getStorage("account"),
      "age":age==""?userInfo['age']:age,
      "sex":sex,
      "userName":userName
    });
  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    loaded=userInfo!=null;
    return GestureDetector(
      onTap:(){
       FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("编辑资料"),
        leading: IconButton(icon: Icon(Icons.chevron_left), onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (contedt){
            return Tabs();
          }));
        }),
      ),
      body:Container(
        color: Color.fromRGBO(180,180,180,0.05),
        child: Column(
        children: <Widget>[
          Container(
            width:width,
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(image:AssetImage("assets/images/edit-info-bg.jpg"),fit: BoxFit.fitHeight)
            ),
            child: Center(child: Container(
              width: 120,
              height: 120,
              child: CircleAvatar(
              backgroundImage: loaded?NetworkImage(userInfo["avatarUrl"]):null,
            ),
            ),)
          ),
          Container(height: 10),
          Card(
            child:Column(
              children: <Widget>[
                ListTile(
                  leading: Text("昵称"),
                  title: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none
                    ),
                    readOnly: !isMine,
                    focusNode: userNameFn,
                    controller:TextEditingController.fromValue(
                      TextEditingValue(text:userName,selection: TextSelection(baseOffset: loaded?userName.length:0, extentOffset: loaded?userName.length:0))
                    ),
                    onChanged: (value){
                      setState(() {
                        userName=value;
                      });
                    },
                    onEditingComplete:updateUserInfo,
                  ),
                ),
                ListTile(
                  leading: Text("年龄"),
                  title: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none
                    ),
                    readOnly: !isMine,
                    focusNode:ageFn,
                     keyboardType: TextInputType.number,
                     inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp("[0-9]")),
                      LengthLimitingTextInputFormatter(2)
                      ],
                    controller:TextEditingController.fromValue(
                      TextEditingValue(
                        text:age,
                        selection: TextSelection(baseOffset: age.length, extentOffset: age.length)
                        // selection: new TextSelection.fromPosition(TextPosition(
                        //   affinity: TextAffinity.downstream,offset: age.length)))
                    ),),
                    onChanged: (value){
                      setState(() {
                        if(value.length!=0){
                          var num=RegExp("[0-9]").firstMatch(value).input;
                          if(num.length>2){
                            age=num.substring(0,2);
                          }else{
                            age=num;
                          }
                        }else{
                          age="";
                        }
                      });
                    },
                    onEditingComplete: updateUserInfo,
                  ),
                ),
                ListTile(
                  leading: Text("性别"),
                  title:GestureDetector(
                    child: Text(sex),
                    onTap:isMine?(){
                      print("点击");
                        new Picker(
                          hideHeader: true,
                          confirmText: "确定",
                          cancelText: "取消",
                          adapter: PickerDataAdapter(
                            data: [
                              PickerItem(text: Text("男")),
                              PickerItem(text: Text("女")),
                              PickerItem(text: Text("保密")),
                              ]
                        ),
                        selecteds: [0],
                        textAlign: TextAlign.center,
                        title: Text("性别"),
                        onConfirm: (Picker picker,List list){
                          setState(() {
                            sex=sexList[list[0]];
                          });
                          updateUserInfo();
                        },
                        onSelect: (Picker picker,int index,List list){
                          print(index);
                        }
                      ).showDialog(context);
                    }:null,
                  )
                )
              ],
            ),
          ),
          (!isMine&&isFriend)?GestureDetector(
            onTap: (){
              print("发送消息");
            },
            child: Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.lightBlue,
              ),
              child: Center(child:Text("发送消息",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
            ),)
          ):Container(),
          (!isMine&&!isFriend)?GestureDetector(
            onTap: (){
              print("添加好友");
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.lightBlue,
              ),
              child:Center(child: Text("添加好友",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
            ),)
          ):Container(),
        ],
      ),
      )
    ),
    );
  }
}
