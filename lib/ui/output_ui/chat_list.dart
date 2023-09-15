part of 'output_ui.dart';


class power_chat_list extends StatefulWidget {
  power_chat_list({Key? key}) : super(key: key);

  @override
  _power_chat_list createState() => _power_chat_list();
}

class _power_chat_list extends State<power_chat_list> {

  // 定义刷新控制器
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{

    // 刷新成功，数据恢复原样
    if (mounted) {
      setState(() {});
    }
    // 重置获取数据LoadStatus
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  void _onLoading() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true, // 下拉刷新
        enablePullUp: true, // 上拉加载数据
        header: WaterDropHeader(),
        footer: CustomFooter( // 设置上拉、下拉时的提示内容
          builder: (context, mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body =  Text("pull up load");
            } else if (mode==LoadStatus.loading) {
              body =  Loading();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: chat_list(),
      ),
    );
  }
}



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