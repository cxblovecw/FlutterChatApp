import 'package:FlutterStudy/pages/chat/chat.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter/material.dart';
class EditInfo extends StatefulWidget {
  @override
  _EditInfoState createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  String userName="";
  String sex="";
  int age=10;
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("编辑资料"),
        leading: IconButton(icon: Icon(Icons.chevron_left), onPressed: (){
          Navigator.pop(context);
        }),
      ),
      body:Container(
        color: Color.fromRGBO(180,180,180,0.05),
        child: ListView(
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
              backgroundImage: NetworkImage("http://172.30.92.225:4200/project/images/avatars/avatar19.jpg"),
            ),
            ),)
          ),
          Container(height: 20,),
          Card(
            child:Column(
              children: <Widget>[
                ListTile(
                  leading: Text("昵称"),
                  title: TextField(
                    controller:TextEditingController.fromValue(
                      TextEditingValue(text: userName)
                    ),
                  ),
                ),
                ListTile(
                  leading: Text("年龄"),
                  title: TextField(
                    controller:TextEditingController.fromValue(
                      TextEditingValue(text: age.toString())
                    ),
                  ),
                ),
                ListTile(
                  leading: Text("性别"),
                  title:GestureDetector(
                    child: Text("男"),
                    onTap: (){
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
                          print(list);
                        },
                        onSelect: (Picker picker,int index,List list){
                          print(index);
                        }
                      ).showDialog(context);
                    },
                  )
                )
              ],
            ),
          ),
        ],
      ),
      )
    );
  }
}