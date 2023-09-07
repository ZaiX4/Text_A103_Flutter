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

    //前面忘了,后面忘了,中间忘了,总之是在自动选择合适的对比度强的颜色方便显示
    //遥遥领先的算法!
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
        child: SelectableText(
          '\n$text\n',
          style: TextStyle(
            color: otherColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),

      );
  }

}



////以下为旧版本内容


//这里首先继承动态组件,搞出一个State，不知道是啥，能跑就行
class chat_bubble extends StatefulWidget {

  //导入参数
  late final String text;
  late final int id;

  chat_bubble({required this.text,required this.id});

  _chat_bubble createState() => _chat_bubble(text:text,id:id);
}


//然后再具体实现，继承State,也就是动态组件,前面的类就是为了返回指定类型的State，已经是最简洁的写法了,那个垂直同步是真的恶心
class _chat_bubble extends State<chat_bubble> with SingleTickerProviderStateMixin{

  //这里要用动画去修改组件的透明度
  int A = 0; // 初始透明度(二进制啊,0到255啊)

  // 定义动画控制器
  late AnimationController _controller;

  //基础
  late final String text;
  late final int id;


  _chat_bubble({required this.text, required this.id});

  void initState() {
    super.initState();

    // 初始化动画控制器
    _controller = AnimationController(

      duration: Duration(seconds: 1), vsync: this, // 动画持续时间为2秒
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
        child: SelectableText(
          '\n$text\n',
          style: TextStyle(
            color: otherColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),

      );
  }

}




//注意,在组件内部声明的变量极其不稳定,会随着listview的重载而释放内存,请不要将重要的,可变的变量放到组件内
Map<int,int>waiting_gpt_flag={};
Map<int,int>get_gpt_flag={};

Map<int,String>gpt_text={};

//这里首先继承动态组件,搞出一个State，不知道是啥，能跑就行
class gpt_chat_bubble extends StatefulWidget {

  //导入参数
  late final String text;
  late final int id;

  gpt_chat_bubble({required this.text,required this.id});


  _gpt_chat_bubble createState() => _gpt_chat_bubble(text:text,id:id);
}


//然后再具体实现，继承State,也就是动态组件,前面的类就是为了返回指定类型的State，已经是最简洁的写法了,那个垂直同步是真的恶心
class _gpt_chat_bubble extends State<gpt_chat_bubble> with SingleTickerProviderStateMixin{

  //这里要用动画去修改组件的透明度
  int A = 0; // 初始透明度(二进制啊,0到255啊)

  // 定义动画控制器
  late AnimationController _controller;

  //基础
  String text='';
  int id=0;
  late String this_gpt_text=gpt_text[id]!;

  final ReceivePort _receivePort = ReceivePort();

  _gpt_chat_bubble({required this.text, required this.id});

  void initState() {

    super.initState();

    // 初始化动画控制器
    _controller = AnimationController(

      duration: Duration(seconds: 1), vsync: this, // 动画持续时间为2秒
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

  //用于等待gpt信息
  Future<void> wait() async {

    _receivePort.listen((dynamic ss) {
      waiting_gpt_flag[id] = 0;
      gpt_text[id] = ss;
      gpt_text[id] = "[GPT]\n"+gpt_text[id]!;
      this_gpt_text = gpt_text[id]!;
    });

    while(waiting_gpt_flag[id]==1){
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        if(waiting_gpt_flag[id]==1) {
          gpt_text[id] = "${gpt_text[id]!}正在生成文本中...\n";
          this_gpt_text = gpt_text[id]!;
        }
      });
    }
  }

  //用于接收gpt信息,开一个新线程
  Future<void> gpt() async {
    wait();
    setState(() {
      gpt_text[id] = "[GPT]\n"+"(ᗜ ˰ ᗜ)正在思考中哦...\n";
      this_gpt_text = gpt_text[id]!;
    });

    // 这里可以执行异步操作，例如加载数据或进行网络请求
    var ss = await get_gpt_text(text);
    setState(() {
      _receivePort.sendPort.send(ss);
    });
  }


  @override
  Widget build(BuildContext context) {

    //只执行一次
    if(get_gpt_flag[id]==1) {
      gpt();
      get_gpt_flag[id] =0;
    }

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
        child: SelectableText(
          '\n$this_gpt_text\n',
          style: TextStyle(
            color: otherColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),

      );
  }

}

