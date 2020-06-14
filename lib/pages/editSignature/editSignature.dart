import 'package:FlutterStudy/tabs.dart';
import 'package:FlutterStudy/utils/DioRequest.dart';
import 'package:FlutterStudy/utils/storage.dart';
import 'package:flutter/material.dart';

class EditSignature extends StatefulWidget {

  @override
  _EditSignatureState createState() => _EditSignatureState();
}

class _EditSignatureState extends State<EditSignature> {
  bool hasSignature=false;
  String signature="";
  @override
  void initState() { 
    super.initState();
    getSignature();
  }
  getSignature()async{
    signature=await getStorage("signature");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "编辑个签",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          Container(
              child: GestureDetector(
                  onTap: hasSignature?()async{
                    request.get("/updateSignature",queryParameters: {
                      "account":await getStorage("account"),
                      "signature":signature
                    }).then((value) => {
                      setStorage("signature", signature),
                      Navigator.push(context,MaterialPageRoute(builder: (context){
                        return Tabs();
                      }))
                    });
                  }:null,
                  child: Center(
                    child: Container(
                        margin: EdgeInsets.only(right: 20),
                        width: 60,
                        height: 25,
                        decoration: BoxDecoration(
                            color: hasSignature?Colors.lightBlue:Colors.black12,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text("发布",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        )),
                  )))
        ],
      ),
      body: Container(
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 10,color: Colors.black12))
        ),
        padding: EdgeInsets.all(10),
        child: TextField(
          controller:  TextEditingController.fromValue(
            TextEditingValue(
                text: signature,
                selection: TextSelection(baseOffset:signature.length, extentOffset: signature.length)
                  )
          ),
          minLines: null,
          maxLength: 80,
          maxLines: null,
          expands: true,
          onChanged: (value)async{
            var primarySignature=await getStorage("signature");
            print(value.length);
            setState((){
              signature=value;
              if(value.length!=0&&primarySignature!=value){
                hasSignature=true;
              }else{
                hasSignature=false;
              }
              print(hasSignature);
            });
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText:"编辑个签，展示我的独特态度。",
            hintStyle: TextStyle(color: Colors.black26,)
          ),
        ),
      ),
    );
  }
}
