import 'package:flutter/foundation.dart';

class no_string extends ChangeNotifier {
  late String value;

  no_string({required this.value});

  void change(var any) {
    value = any;
    notifyListeners(); // 通知监听器变量发生变化
  }
}