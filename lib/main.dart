import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'ui/output_ui/output_ui.dart';
import 'ui/input_ui/input_ui.dart';

import 'package:provider/provider.dart';


void main() {
  FlutterDisplayMode.setHighRefreshRate();
  //以界面为基础创建activity
  runApp(main_screen());
}


class main_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/output',
      routes: {
        '/output': (context) => output_ui(),
        '/input': (context) => input_ui(),
      },
    );


    //2023.9.4 A5版本

  }
}
