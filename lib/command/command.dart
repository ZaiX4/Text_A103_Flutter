import 'dart:core';
import 'package:Xi_XuA/ui/output_ui/output_ui.dart';


void command_ls(String command,String text){
  switch(command){
    case('help'):
      simple_bubble("懒得写");
      break;
    case('gpt'):
      gpt_bubble(text);
      break;
    case('pic'):
      pic_bubble(text);
      break;
  }
}

void run_command(String input){

  RegExp regex = RegExp(r"!(.*?)!");
  RegExp regex2 = RegExp(r"！(.*?)！");

  Iterable<Match> matches = regex.allMatches(input);
  Iterable<Match> matches2 = regex2.allMatches(input);

  String text = input.replaceAll(regex, "").replaceAll(regex2, "")+" ";


  if(matches.isEmpty && matches2.isEmpty){
    gpt_bubble(input);
    return;
  }


  for (Match match in matches) {

    String matchedText = match.group(1) as String; // 获取匹配到的内容

    simple_bubble("检测到指令:"+matchedText.toString());

    command_ls(matchedText,text);

  }

  for (Match match in matches2) {

    String matchedText = match.group(1) as String; // 获取匹配到的内容

    simple_bubble("检测到指令:"+matchedText.toString());

    command_ls(matchedText,text);

  }
}