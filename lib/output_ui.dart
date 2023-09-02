

import 'package:flutter/material.dart';

class output_ui extends StatelessWidget {
  @override
  //当组件被调用时,会触发build函数
  Widget build(BuildContext context) {

    return MaterialApp(
      //顺序构建
      home: Scaffold(

        //内容区域,调用自定义组件
        body: ChatList(),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // 在悬浮按钮被点击时执行的操作
            // 您可以在这里添加您的逻辑，例如导航或显示对话框
            Navigator.pushNamed(context, '/input');
          }, // 在悬浮按钮上显示的文本
          backgroundColor: Colors.blue.withOpacity(0.75), // 悬浮按钮的背景颜色
          shape: CircleBorder(),

          child: const Text(
            "+",

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
      itemCount: 100, // 100个聊天框
      itemBuilder: (BuildContext context, int index) {
        return ChatBubble(
          text: 'Message $index:测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试',

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
      margin: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
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
