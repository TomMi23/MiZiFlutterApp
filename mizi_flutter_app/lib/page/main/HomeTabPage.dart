import 'package:app/common/utils/Toast_Util.dart';
import 'package:app/config/NavigatorUtil.dart';
import 'package:flutter/material.dart';
//import 'package:oktoast/oktoast.dart' as OKToast;

class HomeTabPage extends StatefulWidget {


  HomeTabPage({Key key}) : super(key: key);


  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //elevation: 0.5,
        //brightness: Brightness.light,
        elevation: 0,
        //设置阴影辐射范围
        backgroundColor: Colors.white,
        //Brightness类型，表示当前appbar主题是亮或暗色调，有dark和light两个值，可影响系统状态栏的图标颜色，如下图所示，设为light后状态栏为黑色。设为dark后状态栏颜色为白色
        brightness: Brightness.dark,
        //IconThemeData类型，可影响包括leading、title、actions中icon的颜色、透明度，及leading中的icon大小。
        iconTheme: IconThemeData(color: Colors.black, opacity: 0.5, size: 20),
        title: new Text('米子APP', style: TextStyle(fontSize: 20.0,
            fontWeight: FontWeight.w300,
            color: Colors.black)),
        leading:
        new IconButton(
          icon: ImageIcon(AssetImage("images/tam_toolbar_pop_black.png")),
          onPressed: () {
//            showToast("点击head左侧图标");
            print("点击head左侧图标1");
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              print("点击head中间角查询图标");
            },
            child: Icon(Icons.search),
          ),
          Padding(
            //左右内边距
            padding: const EdgeInsets.only(left: 30.0, right: 20.0),
            child: GestureDetector(
              onTap: () async {
                //弹出菜单
                final result = await showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(50.0, 80.0, 10.0, 50.0),
                    items: <PopupMenuEntry>[
                      new PopupMenuItem<String>(value: 'value01',
                          child: Row(children: <Widget>[
                            Padding(padding: EdgeInsets.fromLTRB(
                                0.0, 0.0, 8.0, 0.0),
                                child: Icon(Icons.directions_car)),
                            new Text('消息中心')])),
                      new PopupMenuDivider(height: 1.0), //水平分割线
                      new PopupMenuItem<String>(value: 'value02',
                          child: Row(children: <Widget>[
                            Padding(padding: EdgeInsets.fromLTRB(
                                0.0, 0.0, 8.0, 0.0),
                                child: Icon(Icons.directions_bike)),
                            new Text('客服')],)),
                    ]);
                //判断点击的某一个事件
                if (result == "value01") {
                  print("点击消息中心");
                }
                if (result == "value02") {
                  print("点击客服");
                }
              },

              //菜单按钮
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body:Stack(
        children: <Widget>[
          new ListView(
            //padding: const EdgeInsets.only(left: 5.0, right: 5.0,top: 10.0),
            children: <Widget>[
              //借点钱部分
              Container(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0,top: 30.0),
                  height: 160.0,
                  width: MediaQuery.of(context).size.width,//宽度设置和屏幕等宽
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("images/home_header_unlogin.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child:new Column(
                    children: <Widget>[
                      //第一行
                      new Container(
                        padding: const EdgeInsets.only(left: 15.0, top: 5.0),
                        child: new Row(

                          children: <Widget>[

                            new Text("最高可借金额",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w700,color: Colors.white),),
                          ],
                        ),
                      ),
                      //第二行
                      new Container(
                        padding: const EdgeInsets.only(left: 15.0, top: 2.0),
                        child: new Row(
                          children: <Widget>[
                            //文本
                            new Expanded(
                              flex: 3,
                              child: new Row(
                                children: <Widget>[
                                  Expanded(
                                      child: new Container(
                                        alignment: Alignment.topLeft,

                                        child: new Text("100,000",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w700,color: Colors.white),),
                                      ))
                                ],
                              ),
                            ),
                            //按钮
                            new Expanded(
                              flex: 2,
                              child: new Row(
                                children: <Widget>[
                                  Expanded(
                                      child: new Container(
                                        alignment: Alignment.topRight,
                                        padding: const EdgeInsets.only(right: 10.0),
                                        child:
                                        new RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(color: Colors.white),//外圈白色
                                            borderRadius: BorderRadius.circular(25),//圆角
                                          ),
                                          color: Colors.transparent, // 设为透明色
                                          elevation: 0, // 正常时阴影隐藏
                                          highlightElevation: 0, // 点击时阴影隐藏
                                          child: new Container(
                                            alignment: Alignment.center,
                                            //height: 10,
                                            child: Text('立即获取额度', style: TextStyle(color: Colors.white, fontSize: 15),),
                                          ),
                                          onPressed: (){
                                            //跳转到登录页面
                                            //Navigator.push(LoginPage(), route)
                                            //NavigatorUtil.gologinPage(context);
                                            Navigator.of(context).pushNamed('/loginPage');
                                          },
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),



                    ],
                  )



              ),
            ],
          ),

        ],
      ),

    );
  }
}