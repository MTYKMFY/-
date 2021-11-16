import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "./NewsPage.dart";

class LoginRegister extends StatelessWidget 
{
  get center => null;

  
  @override
  Widget build(BuildContext context) 
  {
    return DefaultTabController
    (
        length: 2,
        child: Scaffold
        (
          appBar: AppBar(
              title: Container(
              alignment:center,
              child: Text('登录/注册'),
            ),
          ),
          body: TabBarView
          (
            children: <Widget>
            [
              Container(
                // 系统组件
                decoration: BoxDecoration
                (
                    gradient: LinearGradient
                    (
                      colors: [Color(0xFFf15a22), Color(0xFFeb9500)],  //设置背景渐变色
                      begin: Alignment.centerLeft,  //开始
                      end: Alignment.centerRight,   
                    )
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 0, top: 50), //白色容器与渐变色容器有100的顶部空间
                  //alignment:Alignment(0, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0),topRight: Radius.circular(25.0)), //设置顶部圆角
                    
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft, //图标在左上角显示
                          child: IconButton(
                            icon: Icon(
                              Icons.close,   //关闭图标
                              size: 30.0,    //设置图标大小
                            ),
                            onPressed: (){
                              Navigator.pop(context); //点击返回
                              //这里写关闭事件
                            },
                        )
                      ),
                        Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(
                            maxWidth: 150,     //圆形大小
                            maxHeight: 150,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle, //可以设置角度，BoxShape.circle直接圆形
                            color: Colors.blue, //蓝色
                          ),
                          child: Text(
                            '登录',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 55.0,
                              fontFamily: "Courier",
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0,left: 30.0,right: 30.0,top: 30.0),
                          alignment: Alignment.center,
                          child: Material(
                            child: Center(
                              child: TextField(
                                autofocus: true,
                                decoration: InputDecoration(
                                    hintText: "邮箱", prefixIcon: Icon(Icons.email)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 80.0,left: 30.0,right: 30.0),
                          alignment: Alignment.center,
                          constraints: BoxConstraints(
                            maxWidth: 450,
                          ),
                          child: Material(
                            child: Center(
                              child: TextField(
                                autofocus: true,
                                decoration: InputDecoration(
                                    hintText: "密码", prefixIcon: Icon(Icons.lock)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                        width: 300,
                        height: 65,
                        child:RaisedButton(
                          shape: RoundedRectangleBorder
                          (
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: EdgeInsets.all(16.0),
                          color: Colors.blue[700],
                          child: Center
                          (
                            child: Text
                            ("登录",
                                style: TextStyle
                                (
                                  decoration: TextDecoration.none,
                                  fontSize: 15,
                                  color: Colors.white
                                )
                            )
                          ),

                                  //textColor: Colors.white,
                            onPressed: () {},

                        ),  
                      ),
              ],
                    ),
                  ),
                ),
              ),

              ///这里放注册内容
              Container(
                // 系统组件
                decoration: BoxDecoration
                (
                    gradient: LinearGradient
                    (
                      colors: [Color(0xFFf15a22), Color(0xFFeb9500)],  //设置背景渐变色
                      begin: Alignment.centerLeft,  //开始
                      end: Alignment.centerRight,   
                    )
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 0, top: 50), //白色容器与渐变色容器有100的顶部空间
                  //alignment:Alignment(0, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0),topRight: Radius.circular(25.0)), //设置顶部圆角
                    
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft, //图标在左上角显示
                          child: IconButton(
                            icon: Icon(
                              Icons.close,   //关闭图标
                              size: 30.0,    //设置图标大小
                            ),
                            onPressed: (){
                              Navigator.pop(context); //点击返回  
                              //这里写关闭事件
                            },
                        )
                      ),
                        Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(
                            maxWidth: 150,     //圆形大小
                            maxHeight: 150,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle, //可以设置角度，BoxShape.circle直接圆形
                            color:Color(0xFFf15a22), //颜色
                          ),
                          child: Text(
                            '注册',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 55.0,
                              fontFamily: "Courier",
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30.0,right: 30.0,top: 30.0),
                          alignment: Alignment.center,
                          child: Material(
                            child: Center(
                              child: TextField(
                                autofocus: true,
                                decoration: InputDecoration(
                                    hintText: "用户名", prefixIcon: Icon(Icons.email)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0,left: 30.0,right: 30.0),
                          alignment: Alignment.center,
                          child: Material(
                            child: Center(
                              child: TextField(
                                autofocus: true,
                                decoration: InputDecoration(
                                    hintText: "邮箱", prefixIcon: Icon(Icons.email)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 35.0,left: 30.0,right: 30.0),
                          alignment: Alignment.center,
                          constraints: BoxConstraints(
                            maxWidth: 450,
                          ),
                          child: Material(
                            child: Center(
                              child: TextField(
                                autofocus: true,
                                decoration: InputDecoration(
                                    hintText: "密码", prefixIcon: Icon(Icons.lock)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                        width: 300,
                        height: 65,
                        child:RaisedButton(
                          shape: RoundedRectangleBorder
                          (
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: EdgeInsets.all(16.0),
                          color:Color(0xFFf15a22),
                          child: Center
                          (
                            child: Text
                            ("注册",
                                style: TextStyle
                                (
                                  decoration: TextDecoration.none,
                                  fontSize: 15,
                                  color: Colors.white
                                )
                            )
                          ),

                                  //textColor: Colors.white,
                            onPressed: () {},

                        ),  
                      ),
              ],
                    ),
                  ),
                ),
              ),

              
            ]
          )
        )
    );
  }
}

