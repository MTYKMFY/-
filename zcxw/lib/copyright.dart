import 'package:flutter/material.dart';
import './NewsPage.dart';

class Copyright extends StatefulWidget {
  const Copyright({Key key}) : super(key: key);
  @override
  _CopyrightState createState() => new _CopyrightState();
}

class _CopyrightState extends State<Copyright> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  get center => null;
  initState() {

    super.initState();
    
    controller = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);

    //使用弹性曲线
    animation=CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    
    //图片宽高从0变到300
    animation = new Tween(begin: 00.0, end: 300.0).animate(animation);

    //启动动画(正向执行)
    controller.repeat();
    // controller.reverse(from: controller.upperBound);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,   //关闭图标
                  size: 30.0,    //设置图标大小
                ),
                onPressed: (){
                  Navigator.pop(context); //点击返回
                    //这里写关闭事件
                },          
        ),
        title: Container(
          alignment: center,
          child: Text('反馈'),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            AnimatedBuilder(
              animation: animation,
              child: Image.asset("images/Flutter.png"),
              builder: (BuildContext ctx, Widget child) {
                return new Center(
                  child: Container(
                      height: animation.value, 
                      width: animation.value, 
                      child: child,
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(bottom: 60.0),
              alignment: Alignment.center,
              child: Text(
                '联系我',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Text('© 2021 张超'),
            )
          ],
        ),
      ),
    );
  }
}
