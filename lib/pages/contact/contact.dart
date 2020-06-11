import 'package:flutter/material.dart';
import 'package:FlutterStudy/components/search/search.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:ListView(
        children: <Widget>[
          SearchBar()
        ],
      ),
    );
  }
}