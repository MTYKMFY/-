
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import "./LoginRegister.dart";
import 'package:flutter_html/flutter_html.dart';
import './zuohua.dart';
import './Copyright.dart';

class News extends StatefulWidget {
  const News({ Key key , this.data}) : super(key: key); //构造函数中增加参数
  final String data;    //为参数分配空间
  @override
  _MyTabbedPageState createState() => new _MyTabbedPageState();
} 

//定义TAB页对象，这样做的好处就是，可以灵活定义每个tab页用到的对象，可结合Iterable对象使用
class NewsTab {
  String text;
  NewsList newsList;
  NewsTab(this.text,this.newsList);
}

class _MyTabbedPageState extends State<News> with SingleTickerProviderStateMixin {

  //将每个Tab页都结构化处理下，由于http的请求需要传入新闻类型的参数，因此将新闻类型参数值作为对象属性传入Tab中
  final List<NewsTab> myTabs = <NewsTab>[
    new NewsTab('头条',new NewsList(newsType: '头条')),    //第一个'头条'是text，第二newsType: '头条'就是参数值
    new NewsTab('新闻',new NewsList(newsType: '新闻')),
    new NewsTab('国内',new NewsList(newsType: '国内')),
    new NewsTab('国际',new NewsList(newsType: '国际')),
    new NewsTab('政治',new NewsList(newsType: '政治')),
    new NewsTab('财经',new NewsList(newsType: '财经')),
    new NewsTab('体育',new NewsList(newsType: '体育')),
    new NewsTab('娱乐',new NewsList(newsType: '娱乐')),
    new NewsTab('军事',new NewsList(newsType: '军事')),
    new NewsTab('教育',new NewsList(newsType: '教育')),
    new NewsTab('科技',new NewsList(newsType: '科技')),
    new NewsTab('NBA',new NewsList(newsType: 'NBA')),
    new NewsTab('股票',new NewsList(newsType: '股票')),
    new NewsTab('星座',new NewsList(newsType: '星座')),
    new NewsTab('女性',new NewsList(newsType: '女性')),
    new NewsTab('健康',new NewsList(newsType: '健康')),
    new NewsTab('育儿',new NewsList(newsType: '育儿')),
  ];

  TabController _tabController;

  @override
  void initState() {    //进入app的时候执行
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);  //获取新闻频道数,
  }

 @override
 void dispose() {
   _tabController.dispose();  //销毁_tabController的c
   super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        leading: IconButton
        (
          icon:Icon(Icons.account_circle),
          onPressed: ()
          {
            Navigator.push(
              context, MaterialPageRoute(
                  builder: (_) {
                    return LoginRegister();
                }
              )
            );
          },
        ),
        
        title: Container
        (
          alignment: Alignment.topCenter,
          child:Row
          (
          
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("ZCXW",textScaleFactor:2.0),
              IconButton
              (
                icon: Icon(Icons.sync), 
                
                onPressed: (){}
                    
                  

              )
            ],
          ),
        ),
        

        
        
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.send), //Tab(icon: new Icon(Icons.history),text: 'History',),
            
            onPressed: (){
              Navigator.push(
              context, MaterialPageRoute(
                  builder: (_) {
                    return Copyright();
                }
              )
            );
            },
          ),
        ],

      ),
      
      body:Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white70,
          title: TabBar(
            controller: _tabController,
            tabs: myTabs.map((NewsTab item){      //NewsTab可以不用声明
              return Tab(text: item.text??'错误');
            }).toList(),
            labelColor: Colors.red,
            unselectedLabelColor: Colors.black,
            //indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,   //水平滚动的开关，开启后Tab标签可自适应宽度并可横向拉动，关闭后每个Tab自动压缩为总长符合屏幕宽度的等宽，默认关闭
          ),
        ),
        body: new TabBarView(
          controller: _tabController,
          children: myTabs.map((item) {
            return item.newsList; //使用参数值
          }).toList(),
        ),
      ),
    );
  }
}

//新闻列表
class NewsList extends StatefulWidget{
  final String newsType;    //新闻类型
  @override
  NewsList({Key key, this.newsType} ):super(key:key);

  _NewsListState createState() => new _NewsListState();
}


class _NewsListState extends State<NewsList>{

 
  List data;  

  //HTTP请求的函数返回值为异步控件Future
  Future<String> get(String category) async {
    HttpClient httpClient = new HttpClient();
    // var request = await httpClient.getUrl(Uri.parse('${_url}type=$category&key=3a86f36bd3ecac8a51135ded5eebe862'));  
    
    //我的 e0d8b4aed9cf0553
    var request = await httpClient.getUrl(Uri.parse('https://api.jisuapi.com/news/get?channel=$category&start=0&num=10&appkey=e0d8b4aed9cf0553'));  
    var response = await request.close();
    return await response.transform(utf8.decoder).join();
  }

  Future<Null> loadData() async{
    await get(widget.newsType);   //注意await关键字
    if (!mounted) return; //异步处理，防止报错
    setState(() {});//什么都不做，只为触发RefreshIndicator的子控件刷新
  }

  @override
  Widget build(BuildContext context){
    return RefreshIndicator(
      child: FutureBuilder(   //用于加载的FutureBuilder对象
        future: get(widget.newsType),   //HTTP请求获取数据，将被AsyncSnapshot对象监视
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:        //get未执行时
            case ConnectionState.waiting:     //get正在执行时
              return  Center(
                child: Card(
                  child: Text('loading...'),    //在页面中央显示正在加载
                ),
              ) ;
            default:
              if (snapshot.hasError)    //get执行完成但出现异常
                return Text('Error: ${snapshot.error}');
              else  //get正常执行完成
                // 创建列表，列表数据来源于snapshot的返回值，而snapshot就是get(widget.newsType)执行完毕时的快照
                // get(widget.newsType)执行完毕时的快照即函数最后的返回值。
                return createListView(context, snapshot);
          }
        },
      ),
    onRefresh: loadData,
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot){
    // print(snapshot.data);
    List values;
    values = jsonDecode(snapshot.data)['result']!=null?jsonDecode(snapshot.data)['result']['list']:['']; 
    switch (values.length) {
      case 1:   //没有获取到数据，则返回请求失败的原因
        return new Center(
              child: new Card(
                child: new Text(jsonDecode(snapshot.data)['msg']),
              ),
            );
      default:
        return  new ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            // itemCount: data == null ? 0 : data.length,
            itemCount: values == null ? 0 : values.length,
            itemBuilder: (context, i) {
              // return _newsRow(data[i]);//把数据项加入ListView中
                return _newsListener(values[i]);
              }
          );
    }
  }

  Widget _newsListener(newsInfo){
    void _tiaozhuan(newsInfo){
      Navigator.push(context,MaterialPageRoute(builder: (context) {return Htmlnews(string:newsInfo["content"]);},),);
    }
    Offset _coordinate1;
    Offset _coordinate2;
    return new Listener(
      child:_newsRow(newsInfo),
      onPointerDown: (PointerDownEvent event){
        _coordinate1=event.position;
      },
      onPointerUp:(PointerUpEvent event){
        _coordinate2=event.position;
        if (_coordinate1==_coordinate2) {
          _tiaozhuan(newsInfo);
        }
      },
    );

  }

  //新闻列表单个item
  Widget _newsRow(newsInfo){
    return new Card(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new ListTile(title:new Text(newsInfo["title"],textScaleFactor: 1.25,),) ,
            margin: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),),
          _generateOnePicItem(newsInfo),//根据图片数量返回对应样式的图片
          new Container(
            padding:const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
            child:new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Expanded(   
                  child: new Text(newsInfo["src"]),
                ),
                new Expanded(
                  child: new Text(newsInfo["time"]),
                ),
              ],
          )),
          
        ],
      ),
    );
  }


  //仅有一个图片时的效果
  _generateOnePicItem(Map newsInfo){
    return new Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Expanded(
          child: new Container(
            padding: const EdgeInsets.all(3.0),
            child: new SizedBox(
              child: new Image.network(
                newsInfo['pic'],
                fit: BoxFit.fitWidth,
              ),
              height: 200.0,
            )
          )
        )
      ],
    );
  }
}

class Htmlnews extends StatelessWidget {
  final String string;
  Htmlnews({
    Key key, this.string
  }):super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: Zuohua(zujian: ListView(
          children: <Widget>[
            SingleChildScrollView(
              child: Html(data:string),
            ),
            Container(
              child:Text('软件©张超') ,
              alignment: Alignment(0.5, 1),
              )
          ],
        ),
      )
    );
   
  }
}
