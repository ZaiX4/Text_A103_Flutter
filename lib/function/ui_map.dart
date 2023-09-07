
class ui_map{

  List<Map<String,dynamic>>dynamic_ls=[];

  //获取一个新的唯一id,用于创建键值对,ui数量最多为多少亿??
  int new_id(){
    dynamic_ls.add(Map<String,dynamic>());
    return dynamic_ls.length-1;
  }
  //通过唯一id获取ui的变量
  dynamic get(int id,String name){
    return dynamic_ls[id][name];
  }
  //ui初始化变量,可以避免重复初始化
  dynamic init(int id,String name,dynamic value) {

    if(dynamic_ls[id].containsKey(name)){
      return dynamic_ls[id][name];
    }
    dynamic_ls[id][name] = value;
    return value;
  }
  //ui修改变量,请勿将该方法写在ui内部,避免被父组件释放内存影响
  dynamic change(int id,String name,dynamic value) {
    dynamic_ls[id][name] = value;
    return value;
  }

  //追加变量
  dynamic add(int id,String name,dynamic value) {
    dynamic_ls[id][name]+=value;
    return dynamic_ls[id][name];
  }

}

ui_map m = ui_map();






