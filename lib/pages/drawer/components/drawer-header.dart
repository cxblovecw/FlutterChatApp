part of 'package:FlutterStudy/pages/drawer/drawer.dart';

class MyDrawerHeader extends StatelessWidget {
  //  抽屉头部
  @override
  Widget build(BuildContext context) {
    return Container(
              padding: EdgeInsets.only(left:20),
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/drawer-header.jpg"),fit: BoxFit.fitWidth)
              ),
              child:Row(
                mainAxisSize:MainAxisSize.max,
                children:[
                  Expanded(
                    child:Container(
                      padding: EdgeInsets.only(top:15,right: 15),
                      child: Container(
                        width: 60.0,
                        height:80.0,
                        decoration:BoxDecoration(
                          borderRadius:BorderRadius.circular(40.0),
                          image: DecorationImage(image: NetworkImage("https://c-ssl.duitang.com/uploads/item/201803/19/20180319132911_UxCLe.jpeg"),fit:BoxFit.cover)
                        ),
                      )
                    ),flex: 6,),
                  Expanded(child:Container(
                    height: 80.0,
                    child: Container(
                      padding: EdgeInsets.only(top:20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text("我的名称",style: TextStyle(height: 2,fontWeight: FontWeight.w600,color: Colors.white),),
                          Text("个性签名............",maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(height: 2,fontWeight: FontWeight.w600,color: Colors.white))
                        ]
                      ),
                    ),
                  ),flex: 10,),
                  Expanded(child:Container(
                    child: Container(
                      padding:EdgeInsets.only(top:20,right: 5),
                      child:IconButton(icon: Icon(Icons.wallpaper,color: Colors.white,), onPressed: (){
                        print("我的二维码");
                      })
                    ),
                  ),flex: 3,),
                ]
              )
            );
  }
}