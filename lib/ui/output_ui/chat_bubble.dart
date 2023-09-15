part of 'output_ui.dart';

//这里测试船新设计的通用型可变ui架构

//首先我需要一个公有的数据库,以便于管理ui内的数据

//单独拆一个文件出来,方便维护

//以下为2023.9.7内容
void gpt_bubble(String message){

  var i = ui_map.m.new_id();
  ui_map.m.init(i, "message", message);
  //首先添加对话框
  all_chat_ls.add_f(power_chat_bubble(id: i));
  //然后启用gpt函数修改其外部数据,再通过其内部的同步函数传入到内部
  gpt(i);

}

void simple_bubble(String message){

  var i = ui_map.m.new_id();
  ui_map.m.init(i,"text",message);
  ui_map.m.init(i,"wait_gpt_flag",0);
  ui_map.m.init(i,"get_gpt_flag",0);
  all_chat_ls.add_f(power_chat_bubble(id: i));
}

void pic_bubble(String message){

  var i = ui_map.m.new_id();
  ui_map.m.init(i, "message", message);
  ui_map.m.init(i, "picture", Image.network("https://marketplace.canva.cn/evuJ4/MADw9SevuJ4/1/thumbnail_large/canva-MADw9SevuJ4.jpg"));
  all_chat_ls.add_f(picture_chat_bubble(id: i));

  picture(i);
}



class get_color{
  //前面忘了,后面忘了,中间忘了,总之是在自动选择合适的对比度强的颜色方便显示
  //遥遥领先的算法!

  late var id;

  get_color(int id);


}



//以上为构造对话框的函数

class power_chat_bubble extends StatefulWidget {

  //参数精简为id
  late final int id;
  power_chat_bubble({required this.id});
  _power_chat_bubble createState() => _power_chat_bubble(id:id);
}

class _power_chat_bubble extends State<power_chat_bubble> with SingleTickerProviderStateMixin{

  late int id;
  _power_chat_bubble({required this.id});

  // 定义动画控制器
  late AnimationController _controller;
  //这里要用动画去修改组件的透明度
  int A = 0; // 初始透明度(二进制啊,0到255啊)

  //首先我需要一个稳定可变的text
  late String text = ui_map.m.init(id, 'text', "");
  //然后是稳定的flag,表示是否应该等gpt或者召唤gpt
  late int wait_gpt_flag = ui_map.m.init(id,"wait_gpt_flag",1);
  late int get_gpt_flag = ui_map.m.init(id,"get_gpt_flag",1);

  late Timer _timer;

  void dispose() {
    // 在组件销毁时取消计时器，以避免内存泄漏
    _timer.cancel();
    super.dispose();
  }

  //初始化函数,每当组件被listview加载都会执行一次,因此需要一个flag避免gpt api被重复调用
  void initState() {

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // 在计时器回调中更新计数器的值
      setState(() {
        text = ui_map.m.init(id, "text","");
      });
    });

    super.initState();

    // 初始化动画控制器
    _controller = AnimationController(

      duration: Duration(seconds: 1), vsync: this, // 动画持续时间为2秒
    );

    // 创建一个补间动画，将宽度从100.0变化到300.0,其实就是一个不断变化的数值,变化趋势为线性动画
    Animation<double> widthAnimation = Tween<double>(
      begin: 0.0,
      end: 200.0,
    ).animate(_controller);

    // 将数值表现到组件自身,这里的A代表透明度
    widthAnimation.addListener(() {
      setState(() {
        A = widthAnimation.value.toInt();
      });
    });

    // 动画,启动!
    _controller.forward();

  }

  @override
  Widget build(BuildContext context) {

    var x;
    var y;

    x = (id % 20) * 0.05 + 0.05;

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
    Color otherColor = Color.fromARGB(255, y.toInt(), y.toInt(), y.toInt());

    //背景色哦
    Color mainColor = Color.fromARGB(
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
              color: otherColor, // 阴影颜色
              spreadRadius: 6, // 阴影扩散半径
              blurRadius: 0, // 阴影模糊半径
              offset: Offset(0, 4), // 阴影偏移
            ),
          ],

          color: mainColor,

          borderRadius: BorderRadius.circular(10.0),
        ),


        //子组件是一个可以被复制的文本框,请勿修改
        child: Column(
          children:[
            SelectableText(
              '\n$text\n',
              style: TextStyle(
                color: otherColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Loading(),
          ],

        )

      );
  }

}


class picture_chat_bubble extends StatefulWidget {

  //参数精简为id
  late final int id;
  picture_chat_bubble({required this.id});
  _picture_chat_bubble createState() => _picture_chat_bubble(id:id);

}

class _picture_chat_bubble extends State<picture_chat_bubble> with SingleTickerProviderStateMixin{

  late int id;

  late var picture=ui_map.m.get(id, "picture");
  _picture_chat_bubble({required this.id});

  // 定义动画控制器
  late AnimationController _controller;
  //这里要用动画去修改组件的透明度
  int A = 0; // 初始透明度(二进制啊,0到255啊)

  late Timer _timer;

  void dispose() {
    // 在组件销毁时取消计时器，以避免内存泄漏
    _timer.cancel();
    super.dispose();
  }

  //初始化函数,每当组件被listview加载都会执行一次,因此需要一个flag避免gpt api被重复调用
  void initState() {

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // 在计时器回调中更新计数器的值
      setState(() {
        picture = ui_map.m.get(id, "picture");
      });
    });

    super.initState();

    // 初始化动画控制器
    _controller = AnimationController(

      duration: Duration(seconds: 1), vsync: this, // 动画持续时间为2秒
    );

    // 其实就是一个不断变化的数值,变化趋势为线性动画
    Animation<double> widthAnimation = Tween<double>(
      begin: 0.0,
      end: 255.0,
    ).animate(_controller);

    // 将数值表现到组件自身,这里的A代表透明度
    widthAnimation.addListener(() {
      setState(() {
        A = widthAnimation.value.toInt();
      });
    });

    // 动画,启动!
    _controller.forward();

  }

  @override
  Widget build(BuildContext context) {

    var x;
    var y;

    x = (id % 20) * 0.05 + 0.05;

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
    Color otherColor = Color.fromARGB(255, y.toInt(), y.toInt(), y.toInt());

    //背景色哦
    Color mainColor = Color.fromARGB(
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
                color: otherColor, // 阴影颜色
                spreadRadius: 6, // 阴影扩散半径
                blurRadius: 0, // 阴影模糊半径
                offset: Offset(0, 4), // 阴影偏移
              ),
            ],

            color: mainColor,

            borderRadius: BorderRadius.circular(10.0),
          ),


          //子组件是一个可以被复制的文本框,请勿修改
          child: Column(
            children: [
              Text(
                  "[ai绘图]",
                style: TextStyle(
                  color: otherColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              picture,
              Text(""),
              Loading()

            ],
          )


      );
  }

}




