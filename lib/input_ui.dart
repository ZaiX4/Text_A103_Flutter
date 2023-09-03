
import 'package:flutter/material.dart';



class input_ui extends StatelessWidget {

  @override


  Widget build(BuildContext context) {

    TextEditingController get_input_text = TextEditingController();
    //"Scaffold"是Flutter中用来构建应用程序页面基本结构的组件，它提供了顶部的标题栏、底部的导航栏、主要的内容区域和其他常见元素的布局，帮助您创建整洁的应用界面。
    return Scaffold(

      //顶部标题栏
      appBar: AppBar(
        title: Text('输入界面'),
      ),


      body: Align(

          alignment: Alignment.center,

          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(

                  maxLines: 20,
                  minLines: 10,
                  controller: get_input_text,
                  decoration: const InputDecoration(
                    hintText: '输入',
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
      ),

    );
  }


}
