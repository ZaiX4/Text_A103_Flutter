import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import '/function/gpt.dart';
import '/function/ui_map.dart' as ui_map;
import 'dart:isolate';
part 'chat_list.dart';
part 'chat_bubble.dart';
part 'text_divider.dart';


var all_chat_ls = <Widget>[];
var chat_id = 1;

var new_message_num = 0;

var out_put_ui_context;

//扩展方法,我乱写的
extension ListAddToFrontExtension<T> on List<T> {

  void add_f(T elementToAdd) {
    if(elementToAdd is id_divider){
      new_message_num = 0;
      insert(0 , elementToAdd);
    }
    else {
      insert(0 + (new_message_num++), elementToAdd);
    }
  }

  void addAll_f(List<T> elementToAdd){
    for(var i=0;i<elementToAdd.length;++i){
      add_f(elementToAdd[i]);
    }
  }
}

//主输出界面
class output_ui extends StatelessWidget {
  //当组件被调用时,会触发build函数


  output_ui({super.key});

  Widget build(BuildContext context) {

    out_put_ui_context = context;

    //传递一个message过来
    var message = ModalRoute.of(context)?.settings.arguments as String?;

    if (message != null) {

      if(message == "") {
        simple_bubble("(ᗜ ˰ ᗜ)什么也没输入呢");

      }
      else {
        simple_bubble("(ᗜ ˰ ᗜ)检测到输入:");
        simple_bubble("[user_input]\n$message");

        gpt_bubble(message);
      }
      all_chat_ls.add_f(id_divider(text: "这只是一条分割线",));
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
                    colors: [Colors.grey,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.grey],
                  ),
                ),
              ),
              chat_list()
            ]
        ),

        //悬浮按钮
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            // 处理点击事件
            print('FloatingActionButton Clicked');
            Navigator.pushNamed(context, '/input');
            // 在此处执行你的操作
          },
          child: const Text(
            "@",

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

