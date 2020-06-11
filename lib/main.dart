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
  bool logined = false;
  @override
  void initState() { 
    super.initState();
      getStorage("account").then((value)=>{
      print(value),
      setState((){
      logined=value!=null;
      }),
      print(logined)
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ChatApp",
      home: logined?Tabs():LoginPage(),
    );
  }
}
