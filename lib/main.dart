import 'package:Xi_XuA/ui/login_ui/login_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'ui/output_ui/output_ui.dart' as output;
import 'ui/input_ui/input_ui.dart';
import 'package:Xi_XuA/ui/op_ui/op_ui.dart';

import 'package:provider/provider.dart';


void main() {
  FlutterDisplayMode.setHighRefreshRate();
  //以界面为基础创建activity
  output.simple_bubble("版本号A10X");
  output.all_chat_ls.add_f(output.id_divider(text: "开发:曾华堃",));
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
        '/op': (context) => op_ui(),
      },    );


    //2023.9.4 A5版本

  }
}
