part of 'package:FlutterStudy/pages/drawer/drawer.dart';

class MyDrawerFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:60,
      padding: EdgeInsets.fromLTRB(25,0,0,30),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:[
          IconButton(icon:Icon(Icons.directions_run),onPressed: (){
            showDialog(context: context,builder:(context){
              return  MyDialog("退出","是否退出当前账号?",hasCancel: true,callback: (){
                removeStorage("account");
                Navigator.pushReplacement(context,CupertinoPageRoute(builder: (BuildContext context){
                return LoginPage();
            }));
            },);
            });
          
          }),
          IconButton(icon:Icon(Icons.star),onPressed: (){

          }),
          IconButton(icon:Icon(Icons.settings),onPressed: (){
            
          }),
        ]
      )
    );
  }
}