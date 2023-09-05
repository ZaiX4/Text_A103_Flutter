import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'ui/output_ui/output_ui.dart' as output;
import 'ui/input_ui/input_ui.dart';

import 'package:provider/provider.dart';


void main() {
  FlutterDisplayMode.setHighRefreshRate();
  //以界面为基础创建activity
  output.all_chat_ls.add_f(output.chat_bubble(text:"版本号A101",id:0));
  output.all_chat_ls.add_f(output.text_divider(text: "这只是一条分割线",));
  runApp(main_screen());
}


class main_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/output',
      routes: {
        '/output': (context) => output.output_ui(),
        '/input': (context) => input_ui(),
      },
    );


    //2023.9.4 A5版本

  }
}
