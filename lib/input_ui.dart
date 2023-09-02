
import 'package:flutter/material.dart';

class input_ui extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('输入界面'),
      ),
      body: Column(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '在此输入',
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // 处理发送按钮点击事件
              // 可以在这里执行消息发送逻辑
              Navigator.pop(context);
            },
            child: Text('发送'),
          ),
        ],
      ),
    );
  }


}
