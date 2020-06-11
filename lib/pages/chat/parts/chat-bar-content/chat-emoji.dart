part of '../../chat.dart';

class ChatEmoji extends StatefulWidget {
  @override
  _ChatEmojiState createState() => _ChatEmojiState();
}

class _ChatEmojiState extends State<ChatEmoji> {
  List<String> emojis;
  @override
  void initState() {
    super.initState();
    emojis=["😀","😁","😂","😃","😄","😅","😆","😉",'😊','😋','😎','😍','😘','😗','😙','😚','😇','😐','😑','😶','😏','😣','😥','😮','😯','😪','😫','😴','😌','😛','😜','😝','😒','😓','😔','😕','😲','😷','😖','😞','😟','😤','😢','😭','😦','😧','😨','😬','😰','😱','😳','😵','😡','😠','💪','👈','👉','☝','👆','👇','✌','✋','👌','👍','👎','✊','👊','👋','👏','👐','✍','🍇','🍈','🍉','🍊','🍋','🍌','🍍','🍎','🍏','🍐','🍑','🍒','🍓'];
  }
  @override
  Widget build(BuildContext context) {
      // 表情功能内容
      return Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height*0.36,
        width: double.infinity,
        child: ListView(
          children: <Widget>[
            Wrap(children:List.generate(emojis.length, 
            (index) => GestureDetector(  //点击将表情添加到输入框中
              onTap: (){
                setState(() {
                  controller.text+=emojis[index];
                });
                print(controller.text);
              },
              child: Container(
                margin: EdgeInsets.all(10),
                width: 30,
                height: 30,
                child: Text("${emojis[index]}",style: TextStyle(fontSize: 25),textAlign: TextAlign.center,),
              ),
            )
            ))
          ],
        ),
    );
  }
}
