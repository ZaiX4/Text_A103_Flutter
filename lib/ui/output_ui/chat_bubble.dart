part of 'output_ui.dart';


//这里要测试新学的动态更新组件


//这里首先继承动态组件,搞出一个State，不知道是啥，能跑就行
class chat_bubble extends StatefulWidget {
  //这里乱写的,说不定能跑
  late final String text;
  late final int id;

  chat_bubble({required this.text,required this.id});

  _chat_bubble createState() => _chat_bubble(text:this.text,id:this.id);
}


//然后再具体实现，继承State,也就是动态组件,前面的类就是为了返回指定类型的State，已经是最简洁的写法了,那个垂直同步是真的恶心
class _chat_bubble extends State<chat_bubble> with SingleTickerProviderStateMixin{

  //这里要用动画去修改组件的透明度
  int A = 0; // 初始透明度(二进制啊,0到255啊)

  // 定义动画控制器
  late AnimationController _controller;



  //这里我乱写的,说不定能跑
  late final String text;
  late final int id;

  _chat_bubble({required this.text, required this.id});

  void initState() {
    super.initState();

    // 初始化动画控制器
    _controller = AnimationController(

      duration: Duration(seconds: 2), vsync: this, // 动画持续时间为2秒
    );

    // 创建一个补间动画，将宽度从100.0变化到300.0
    Animation<double> widthAnimation = Tween<double>(
      begin: 0.0,
      end: 255.0,
    ).animate(_controller);

    // 添加一个监听器，当动画值发生变化时，更新状态
    widthAnimation.addListener(() {
      setState(() {
        A = widthAnimation.value.toInt();
      });
    });

    // 启动动画
    _controller.forward();
  }


  @override
  Widget build(BuildContext context) {
    //前面忘了,后面忘了,中间忘了,总之是在自动选择合适的对比度强的颜色方便显示
    //遥遥领先!
    var x = (id % 20) * 0.05 + 0.05;
    var y;

    //已经很完美了,这个颜色算法
    if (x >= 0.4 && x <= 0.5) {
      x = 0.4;
    }
    if (x >= 0.5 && x <= 0.6) {
      x = 0.6;
    }

    if (x <= 0.5) {
      y = 128 - (x * 255);
    }
    else {
      y = 255 * x / 2 + 128;
      if (y >= 200) {
        y = 200;
      }
    }

    //透明度
    x = (id % 20) * 0.05 + 0.05;

    //对比色,也可以称作副颜色
    Color other_color = Color.fromARGB(255, y.toInt(), y.toInt(), y.toInt());

    //背景色哦
    Color main_color = Color.fromARGB(
        A, (255 * (1 - x)).toInt(), (255 * (1 - x)).toInt(),
        (255 * (1 - x)).toInt());


    return
      Container(

        //这里是设置边距,改了就崩
        margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        padding: EdgeInsets.all(12.0),


        //这里是设置阴影和颜色
        decoration: BoxDecoration(

          boxShadow: [
            BoxShadow(
              color: other_color, // 阴影颜色
              spreadRadius: 6, // 阴影扩散半径
              blurRadius: 0, // 阴影模糊半径
              offset: Offset(0, 4), // 阴影偏移
            ),
          ],

          color: main_color,

          borderRadius: BorderRadius.circular(10.0),
        ),


        //子组件是一个可以被复制的文本框,请勿修改
        child: SelectableText(
          '\n$text\n',
          style: TextStyle(
            color: other_color,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),

      );
  }

}

//这是个对话框,A5版本限定
/**
class chat_bubble extends StatelessWidget {

  //final是真没必要,但能跑就行
  final String text;
  final int id;

  chat_bubble({required this.text,required this.id});

  @override
  Widget build(BuildContext context) {

    //前面忘了,后面忘了,中间忘了,总之是在自动选择合适的对比度强的颜色方便显示
    //遥遥领先!
    var x = (id % 20) *0.05 + 0.05;
    var y;

    //已经很完美了,这个颜色算法
    if(x>=0.4&&x<=0.5){
      x = 0.4;
    }
    if(x>=0.5&&x<=0.6){
      x = 0.6;
    }

    if(x<=0.5){
      y = 128-(x*255);
    }
    else {
      y = 255*x/2+128;
      if(y>=200){
        y=200;
      }
    }

    //透明度
    x = (id % 20) *0.05 + 0.05;

    //对比色,也可以称作副颜色
    Color other_color = Color.fromARGB(255, y.toInt(), y.toInt(), y.toInt());

    //背景色哦
    Color main_color = Color.fromARGB(255, (255*(1-x)).toInt(), (255*(1-x)).toInt(), (255*(1-x)).toInt());


    return
      Container(

        //这里是设置边距,改了就崩
        margin: EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
        padding: EdgeInsets.all(12.0),


        //这里是设置阴影和颜色
        decoration: BoxDecoration(

          boxShadow: [
            BoxShadow(
              color: other_color, // 阴影颜色
              spreadRadius: 6, // 阴影扩散半径
              blurRadius: 0, // 阴影模糊半径
              offset: Offset(0, 4), // 阴影偏移
            ),
          ],

          color: main_color,

          borderRadius: BorderRadius.circular(10.0),
        ),


        //子组件是一个可以被复制的文本框,请勿修改
        child: SelectableText(
          '\n$text\n',
          style: TextStyle(
            color: other_color,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),

      );
  }
}
*/