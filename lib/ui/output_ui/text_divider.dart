part of 'output_ui.dart';

//这个是分割线,很重要(外观层面)


class text_divider extends StatelessWidget{

  String text;
  text_divider({required this.text});

  //这个没啥好注释的
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