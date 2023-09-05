import 'dart:ffi';

import 'package:flutter/material.dart';
import '/function/gpt.dart';
part 'chat_list.dart';
part 'chat_bubble.dart';
part 'text_divider.dart';


var all_chat_ls = <Widget>[];
var chat_id = 1;

var new_message_num = 0;

//扩展方法,我乱写的
extension ListAddToFrontExtension<T> on List<T> {

  void add_f(T elementToAdd) {
    if(elementToAdd is text_divider){
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



//这个是用来召唤gpt的
Future<void> add_gpt_chat(String message) async {
  var c_chat_id = chat_id;
  var add = chat_bubble(text: "GPT正在思考中，请稍后...", id: chat_id++);
  all_chat_ls.add_f(add);

  String ss = await get_gpt_text(message);

  for(var i=0;i<all_chat_ls.length;++i){
    if(all_chat_ls[i]==add){
      all_chat_ls[i]=chat_bubble(text: "[GPT]\n$ss", id: c_chat_id);
      break;
    }
  }

}


//主输出界面
class output_ui extends StatelessWidget {
  //当组件被调用时,会触发build函数


  output_ui({super.key});

  Widget build(BuildContext context) {

    //传递一个message过来
    var message = ModalRoute.of(context)?.settings.arguments as String?;

    if (message != null) {
      // 参数不为空，可以使用它

      var st=chat_id;

      if(message == "") {
        all_chat_ls.add_f(chat_bubble(text: "(ᗜ ˰ ᗜ)什么也没输入呢",id: chat_id++,));

      }
      else {
        all_chat_ls.add_f(chat_bubble(text: "(ᗜ ˰ ᗜ)检测到输入:",id: chat_id++,));
        all_chat_ls.add_f(chat_bubble(text: "[user_input]\n$message",id: chat_id++,));
        add_gpt_chat(message);

      }
      ;

      var ed=chat_id-1;
      String ss=st.toString()+"~"+ed.toString();
      all_chat_ls.add_f(text_divider(text: ss,));
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

