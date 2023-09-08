
import 'package:flutter/material.dart';



class input_ui extends StatelessWidget {

  @override


  Widget build(BuildContext context) {

    TextEditingController get_input_text = TextEditingController();

    String command_text =
        "欢迎来到输入界面,请单击文本框以输入\n"
        "在文中添加指令可以使用更多功能\n"
        "指令格式为!指令!,如!gpt!或!pic!\n"
        "使用gpt提问可以输入 !gpt! 你好\n"
        "使用ai生成图片可以输入 !pic! 坚果\n"
        "获取更多指令信息请输入 !help! 指令\n";
    //"Scaffold"是Flutter中用来构建应用程序页面基本结构的组件，它提供了顶部的标题栏、底部的导航栏、主要的内容区域和其他常见元素的布局，帮助您创建整洁的应用界面。
    return Scaffold(

      //顶部标题栏
      appBar: AppBar(
        title: Text('输入界面'),
      ),


      body: Align(

          alignment: Alignment.center,

          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextFormField(

                      maxLines: 200,
                      minLines: 10,
                      controller: get_input_text,
                      decoration: InputDecoration(
                        hintText: command_text,
                      ),
                    ),
                  ),

                  ElevatedButton(

                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/output',
                        arguments: get_input_text.text,
                      );
                    },
                    child: const Text(
                        '发送'

                    ),
                  ),
                ],
              )
            ],
          )

      ),

    );
  }


}
