import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'output_ui.dart';
import 'input_ui.dart';


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
  }


}
