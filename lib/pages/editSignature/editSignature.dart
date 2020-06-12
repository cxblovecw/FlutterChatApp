import 'package:flutter/material.dart';
class EditSignature extends StatefulWidget {
  @override
  _EditSignatureState createState() => _EditSignatureState();
}

class _EditSignatureState extends State<EditSignature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("编辑个签"),
        leading: IconButton(icon: Icon(Icons.chevron_left), onPressed: (){
          Navigator.pop(context);
        }),
      ),
    );
  }
}