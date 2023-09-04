
import 'package:flutter/material.dart';

var all_chat_ls = <Widget>[];
var new_chat_ls = <Widget>[];
var Chat_id = 1;

extension ListAddToFrontExtension<T> on List<T> {

  void add_f(T elementToAdd) {
    insert(0, elementToAdd);
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

    //传递一个message过来
    var message = ModalRoute.of(context)?.settings.arguments as String?;
    new_chat_ls.clear();

    if (message != null) {
      // 参数不为空，可以使用它

      var st=Chat_id;

      if(message == "") {
        new_chat_ls.add_f(ChatBubble(text: "(ᗜ ˰ ᗜ)什么也没输入呢",id: Chat_id++,));

      }
      else {
        new_chat_ls.add_f(ChatBubble(text: "(ᗜ ˰ ᗜ)检测到输入:",id: Chat_id++,));
        new_chat_ls.add_f(ChatBubble(text: "[user_input]\n$message",id: Chat_id++,));

      }
      all_chat_ls.addAll_f(new_chat_ls);
      ;

      var ed=Chat_id-1;
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
              ChatList()
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

//列表
class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //列表
    return ListView.builder(

      itemCount: all_chat_ls.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: all_chat_ls[index]
        );
      },
    );
  }
}


//那个对话框
class ChatBubble extends StatelessWidget {
  final String text;
  final int id;

  ChatBubble({required this.text,required this.id});

  @override
  Widget build(BuildContext context) {

    var x = (id % 20) *0.05 + 0.05;

    var y;

    if(x>=0.4&&x<=0.5){
      x = 0.4;
    }
    if(x>=0.5&&x<=0.6){
      x = 0.6;
    }

    if(x<=0.5){
      y = 128-(x*255);
    }
    else {
      y = 128+((1-x)*255);
    }


    x = (id % 20) *0.05 + 0.05;  //透明度

    Color textColor = Color.fromARGB(255, y.toInt(), y.toInt(), y.toInt());


    Color mainColor = Color.fromARGB(255, (255*(1-x)).toInt(), (255*(1-x)).toInt(), (255*(1-x)).toInt());

    return Container(

      margin: EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
      padding: EdgeInsets.all(12.0),

      //设置样式
      decoration: BoxDecoration(

        boxShadow: [
          BoxShadow(
            color: textColor, // 阴影颜色
            spreadRadius: 6, // 阴影扩散半径
            blurRadius: 0, // 阴影模糊半径
            offset: Offset(0, 4), // 阴影偏移
          ),
        ],

        color: mainColor,

        borderRadius: BorderRadius.circular(10.0),
      ),

      child: SelectableText(
        '\n$text\n',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),

    );
  }
}


//这个是分割线,很重要
class text_divider extends StatelessWidget{
  @override

  String text;
  text_divider({required this.text});
  Widget build(BuildContext context) {


    return Center(
      child: Column(
        children: [

          Divider(
            color: Colors.black,
          ),

          Text(this.text),

          Divider(
            color: Colors.black,
          ),

        ],
      ),
    );

  }

}