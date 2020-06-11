import 'package:FlutterStudy/components/dialog/dialog.dart';
import 'package:FlutterStudy/pages/login/login.dart';
import 'package:FlutterStudy/utils/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:FlutterStudy/pages/collection/collection.dart';
part 'package:FlutterStudy/pages/drawer/components/drawer-content.dart';
part 'package:FlutterStudy/pages/drawer/components/drawer-footer.dart';
part 'package:FlutterStudy/pages/drawer/components/drawer-header.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
       child: Container(
         padding: EdgeInsets.zero,
         child:Column(
           children:[
            MyDrawerHeader(),
            MyDrawerContent(),
            MyDrawerFooter()
           ]
         )
       ),
      );
  }
}