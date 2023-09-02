import 'package:flutter/material.dart';
import 'output_ui.dart';
import 'input_ui.dart';

void main() {

  //以界面为基础创建activity
  runApp(main_screen());
}

class main_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/out',
      routes: {
        '/out': (context) => output_screen(),
        '/input': (context) => input_screen(),
      },
    );
  }


}
