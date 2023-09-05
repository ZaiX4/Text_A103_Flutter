part of 'output_ui.dart';


//这是个列表
class chat_list extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //这是个builder动态列表,与公有变量all_chat_ls绑定
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