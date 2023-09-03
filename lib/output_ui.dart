
import 'package:flutter/material.dart';

var chat_ls = <ChatBubble>[];


class output_ui extends StatelessWidget {
  @override
  //当组件被调用时,会触发build函数

  Widget build(BuildContext context) {

    //传递一个message过来
    var message = ModalRoute.of(context)?.settings.arguments as String?;


    if (message != null) {
      // 参数不为空，可以使用它

      if(message == "") {
        chat_ls.add(ChatBubble(text: "(ᗜ ˰ ᗜ)什么也没输入呢",id: chat_ls.length+1,));
      }
      else {
        chat_ls.add(ChatBubble(text: "(ᗜ ˰ ᗜ)检测到输入:",id: chat_ls.length+1,));
        chat_ls.add(ChatBubble(text: "[user_input]\n$message",id: chat_ls.length+1,));
      }
    }


    return MaterialApp(
      //顺序构建
      home: Scaffold(

        //内容区域,调用自定义组件
        body: Stack(
          children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white,Colors.white70],
              ),
            ),
          ),
            ChatList()
          ]
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue.withOpacity(0.75), // 设置透明度
          onPressed: () {
            // 处理点击事件
            print('FloatingActionButton Clicked');
            Navigator.pushNamed(context, '/input');
            // 在此处执行你的操作
          },
          child: const Text(
            "@",

            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ),

      ),

    );
  }

}


class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ListView.builder(

      itemCount: chat_ls.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: chat_ls[index]
        );
      },
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final int id;

  ChatBubble({required this.text,required this.id});

  @override
  Widget build(BuildContext context) {

    var x = (id % 20) *0.05 + 0.05;


    if(x>=0.2 && x<=0.4){
      x = 0.2;
    }
    if(x>=0.4 && x<=0.6){
      x = 0.6;
    }

    var y;
    if(x>=0.6){
      y = -255 * (x-1)*(x-1)*(x-1)*(x-1)*(x-1)*(x-1) + 255;
    }
    else {
      y = -255 * (x-1)*(x-1) + 255;
    }


    Color text_color = Color.fromARGB(255, y.toInt(), y.toInt(), y.toInt());

    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // 阴影颜色
            spreadRadius: 3, // 阴影扩散半径
            blurRadius: 5, // 阴影模糊半径
            offset: Offset(0, 3), // 阴影偏移
          ),
        ],
        color: Colors.blue.withOpacity((id % 20) *0.05 + 0.05),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SelectableText(
        '\n$text\n',
        style: TextStyle(
          color: text_color,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),

    );
  }
}
