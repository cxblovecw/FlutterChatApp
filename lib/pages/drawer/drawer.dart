import 'package:FlutterStudy/components/dialog/dialog.dart';
import 'package:FlutterStudy/pages/info/info.dart';
import 'package:FlutterStudy/pages/editSignature/editSignature.dart';
import 'package:FlutterStudy/pages/login/login.dart';
import 'package:FlutterStudy/pages/qrCode/qrCode.dart';
import 'package:FlutterStudy/utils/DioRequest.dart';
import 'package:FlutterStudy/utils/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:FlutterStudy/pages/collection/collection.dart';
part 'package:FlutterStudy/pages/drawer/components/drawer-content.dart';
part 'package:FlutterStudy/pages/drawer/components/drawer-footer.dart';
part 'package:FlutterStudy/pages/drawer/components/drawer-header.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
   Map userInfo;
   @override
   void initState() { 
     super.initState();
     getAvatarUrl();
   }
   getAvatarUrl()async{
    request.get('/info',queryParameters: {"account":await getStorage("account")}).then((value)async=>{
      setState((){
        userInfo=value.data;
      })
    });
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
       child: Container(
         padding: EdgeInsets.zero,
         child:Column(
           children:[
            MyDrawerHeader(userInfo),
            MyDrawerContent(),
            MyDrawerFooter()
           ]
         )
       ),
      );
  }
}