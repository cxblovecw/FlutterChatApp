part of 'package:FlutterStudy/pages/drawer/drawer.dart';

class MyDrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:Container(
        padding:EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            ListTile(
              leading:Icon(Icons.shopping_basket),
              title: Text("我的钱包"),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              leading:Icon(Icons.photo_size_select_actual),
              title: Text("我的相册"),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              leading:Icon(Icons.star_border),
              title: Text("我的收藏"),
              trailing: Icon(Icons.chevron_right),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder:(context){
                  return Collection();
                }));
              },
            ),
          ],
        ),
      )
    );
  }
}