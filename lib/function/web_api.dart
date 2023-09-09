
import 'dart:convert';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '/function/ui_map.dart' as ui_map;

String model="gpt-3.5-turbo";

Future<String> get_gpt_text(String message) async {

  var headers = {
    'Authorization': 'Bearer fk213655-B4BA0Go0HuPYSwS5fI9Xbx7N9TNDMMvT',
    'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
    'Content-Type': 'application/json'
  };

  var request = http.Request('POST', Uri.parse('https://oa.api2d.net/v1/chat/completions'));
  request.body = json.encode({
    "model": model,
    "messages": [
      {
        "role": "user",
        "content": message
      }
    ],
    "safe_mode": false
  });
  model = "gpt-3.5-turbo";
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var ss = await response.stream.bytesToString();
    return json.decode(ss)['choices'][0]['message']['content'].toString();
  }
  else {
    return response.reasonPhrase.toString();
  }

}

Future<String> get_piture_url(String message) async {
  var headers = {
    'Authorization': 'Bearer fk213655-B4BA0Go0HuPYSwS5fI9Xbx7N9TNDMMvT',
    'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('https://oa.api2d.net/v1/images/generations'));
  request.body = json.encode({
    "prompt": message,
    "response_format": "url",
    "size": "1024x1024"
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var ss = await response.stream.bytesToString();
    return json.decode(ss)['data'][0]['url'];
  }
  else {
  return response.reasonPhrase.toString();
  }

}

/*
变量协议:
  //首先我需要一个稳定可变的text
  late String text = ui_map.m.init(id, 'text', "");
  //然后是稳定的线程数据管理器
  late ReceivePort _receivePort = ui_map.m.init(id, "_receivePort", ReceivePort());
  //然后是稳定的啥啊,啊对了,应该是flag,表示是否应该等gpt或者召唤gpt
  late int wait_gpt_flag = ui_map.m.init(id,"wait_gpt_flag",1);
  late int get_gpt_flag = ui_map.m.init(id,"get_gpt_flag",1);
 */

//用于等待gpt信息
Future<void> wait(var id,var _receivePort) async {

  _receivePort.listen((dynamic ss) {
    ui_map.m.change(id, "wait_gpt_flag",0);
    ui_map.m.change(id, "text","[GPT]\n"+ss);
  });

  while(ui_map.m.get(id, "wait_gpt_flag") == 1){
    await Future.delayed(Duration(seconds: 1));
    if(ui_map.m.get(id, "wait_gpt_flag")==1) {
      ui_map.m.add(id,"text","正在生成文本中...\n");
    }
  }

}

//用于接收gpt信息,开一个新线程
Future<void> gpt(var id) async {

  ui_map.m.init(id, "wait_gpt_flag", 1);

  ReceivePort _receivePort = ReceivePort();
  wait(id,_receivePort);
  //先改text
  ui_map.m.change(id, "text", "(ᗜ ˰ ᗜ)正在思考中哦...\n");
  ui_map.m.add(id, "text", ui_map.m.get(id, "message")+"\n");

  // 这里可以执行异步操作，例如加载数据或进行网络请求
  var ss = await get_gpt_text(ui_map.m.get(id, "message").toString());

  _receivePort.sendPort.send(ss);

}

Future<void> picture(var id) async{

  ui_map.m.change(id, "picture", Image.network("https://marketplace.canva.cn/evuJ4/MADw9SevuJ4/1/thumbnail_large/canva-MADw9SevuJ4.jpg"));
  var ss = await get_piture_url(ui_map.m.get(id, "message").toString());

  ui_map.m.change(id, "picture", Image.network(ss));
}