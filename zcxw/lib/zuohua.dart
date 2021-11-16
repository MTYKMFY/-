import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//第二个右滑思路,应该叫滑动思路,和第一个相似
//ver 1.1 如果用判定左右滑动同时在一个区域里 会产生冲突,本来我只想让他有右滑功能,所以要单独分出左滑.
class Zuohua extends StatefulWidget {
  Zuohua(
    {
      Key key,
      this.zujian,
    }
  ):super(key:key);
  final Widget zujian;

  @override
  _ZuohuaState createState() => _ZuohuaState();
}

class _ZuohuaState extends State<Zuohua> {
  double _left = 0.0;
   double _f;  
  double bg(x){
      return _f=x;
  }

   void ng(){
      if (_f<_left) {    
      Navigator.pop(context);
      }
       else{
             print(1);
       }
  }

  @override
    Widget build(BuildContext context){
      return Container(
        child: GestureDetector(
          //GestureDetector手势组件
            behavior: HitTestBehavior.translucent,
            onHorizontalDragDown:(DragDownDetails details){
            } ,
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              
              _left=_f+details.delta.dx;
            
            },
            onHorizontalDragEnd: (DragEndDetails details) {
            ng();
            },
             child: widget.zujian,
          )
      );
    }
}