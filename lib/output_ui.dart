

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
        message = "什么也没输入呢(ᗜ ˰ ᗜ)";
        chat_ls.add(ChatBubble(text: message));
      }
      else {
        message = "(ᗜ ˰ ᗜ)检测到输入:$message";
        chat_ls.add(ChatBubble(text: message));
      }
    }


    return MaterialApp(
      //顺序构建
      home: Scaffold(

        //内容区域,调用自定义组件
        body: ChatList(),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // 处理点击事件
            print('FloatingActionButton Clicked');
            Navigator.pushNamed(context, '/input');
            // 在此处执行你的操作
          },
          child: const Text(
            "?",

            style: TextStyle(
              color: Colors.black,
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

  ChatBubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SelectableText(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
