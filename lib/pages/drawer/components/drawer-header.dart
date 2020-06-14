part of 'package:FlutterStudy/pages/drawer/drawer.dart';

class MyDrawerHeader extends StatelessWidget {
  Map userInfo;
  MyDrawerHeader(this.userInfo);
  //  抽屉头部
  @override
  Widget build(BuildContext context) {
    var loaded=userInfo!=null;
    var signatureLength=loaded?userInfo["signature"].length:0;
    var signature=(loaded&&signatureLength>0)?userInfo["signature"][signatureLength-1]['text']:"";
    setStorage("signature",signature);
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
                    child:GestureDetector(onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                              return Info(account:"10000",);
                            }));
                          }, child:Container(
                      padding: EdgeInsets.only(top:15,right: 15),
                      child: Container(
                        width: 60.0,
                        height:80.0,
                        decoration:BoxDecoration(
                          borderRadius:BorderRadius.circular(40.0),
                          image: loaded?DecorationImage(image:NetworkImage(userInfo["avatarUrl"]),fit:BoxFit.cover):null
                        ),
                      )
                    )),flex: 6,),
                  Expanded(child:Container(
                    height: 80.0,
                    child: Container(
                      padding: EdgeInsets.only(top:20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          GestureDetector(onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                              return Info(account: userInfo['account'].toString(),);
                            }));
                          }, child: Text(loaded?userInfo["userName"]:"",style: TextStyle(height: 2,fontWeight: FontWeight.w600,color: Colors.white),),),
                          GestureDetector(onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                              return EditSignature();
                            }));
                          }, child:Text((loaded&&signatureLength>0)?userInfo["signature"][signatureLength-1]['text']:"编辑个签，展示自我 ! !",maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(height: 2,fontWeight: FontWeight.w600,color: Colors.white)))
                        ]
                      ),
                    ),
                  ),flex: 10,),
                  Expanded(child:Container(
                    child: Container(
                      padding:EdgeInsets.only(top:20,right: 5),
                      child:IconButton(icon: Icon(Icons.wallpaper,color: Colors.white,), onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (BuildContext context){
                          return MyQrCode();
                        }));
                      })
                    ),
                  ),flex: 3,),
                ]
              )
            );
  }
}