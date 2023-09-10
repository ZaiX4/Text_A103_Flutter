import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';


var op_ui_context;

class op_ui extends StatefulWidget {
  @override
  _op_ui createState() => _op_ui();
}

class _op_ui extends State<op_ui> {

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/op.mp4')
      ..initialize().then((_) {
        // 确保控制器已经初始化完成

        setState(() {});
        _controller.play();

      });

  }

  @override
  Widget build(BuildContext context) {

    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {
        // 使用 Navigator 导航到 '/output' 路由
        Navigator.of(context).pushNamed('/output');
      }
    });

    op_ui_context = context;
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : CircularProgressIndicator(), // 加载时显示进度条
        )
      ],
    );

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}