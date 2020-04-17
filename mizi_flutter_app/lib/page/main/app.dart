
import 'package:flutter/material.dart';
import 'HomeTabPage.dart';
import 'MyTabPage.dart';

//应用页面使用有状态Widget
class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

//应用页面状态实现类
class AppState extends State<App> {
  //当前选中页面索引
  var _currentIndex = 0;

  //借点钱借钱
  HomeTabPage homeTabPage;

  //我的页面
  MyTabPage myTabPage;

  //根据当前索引返回不同的页面
  currentPage() {
    switch (_currentIndex) {
      case 0:
        if (homeTabPage == null) {
          homeTabPage = new HomeTabPage();
        }
        return homeTabPage;
      case 1:
        if (myTabPage == null) {
          myTabPage = new MyTabPage();
        }
        return myTabPage;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //底部导航按钮
      bottomNavigationBar: new BottomNavigationBar(
        //通过fixedColor设置选中item 的颜色
        type: BottomNavigationBarType.fixed,
        //当前页面索引
        currentIndex: _currentIndex,
        //按下后设置当前页面索引
        onTap: ((index) {
          setState(() {
            _currentIndex = index;
          });
        }),
        //底部导航按钮项
        items: [
          //导航按钮项传入文本及图标
          new BottomNavigationBarItem(
              title: new Text('首页',
                style: TextStyle(color: _currentIndex == 0 ? Color(0xFF46c01b) : Color(0xff999999)),
              ),
              //判断当前索引作图片切换显示
              icon: _currentIndex == 0
                  ? Image.asset('images/message_pressed.png', width: 32.0, height: 28.0,)
                  : Image.asset('images/message_normal.png', width: 32.0, height: 28.0,)
          ),
          new BottomNavigationBarItem(
              title: new Text('我的',
                style: TextStyle(color: _currentIndex == 2 ? Color(0xFF46c01b) : Color(0xff999999)),
              ),
              icon: _currentIndex == 1
                  ? Image.asset('images/profile_pressed.png', width: 32.0, height: 28.0,)
                  : Image.asset('images/profile_normal.png', width: 32.0, height: 28.0,)
          ),
        ],
      ),
      //中间显示当前页面
      body: currentPage(),
    );
  }

}
