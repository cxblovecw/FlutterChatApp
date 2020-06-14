import 'package:FlutterStudy/pages/login/login.dart';
import 'package:FlutterStudy/utils/storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'tabs.dart';

void main() async => {runApp(App())};

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool logined;
  @override
  void initState() { 
    super.initState();
      
  }
  isLoaded()async{
     await getStorage("account").then((value)=>{
      setState((){
        logined=value!=null;
      }),
    });
  }
  @override
  Widget build(BuildContext context) {
    isLoaded();
    return MaterialApp(
      title: "ChatApp",
      home: logined!=null?(logined?Tabs():LoginPage()):Scaffold(),
    );
  }
}
