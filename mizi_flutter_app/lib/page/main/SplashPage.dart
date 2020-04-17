import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';


//加载页面
class SplashPage extends StatefulWidget {
  SplashPage({Key key}):super(key:key);
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<SplashPage> {

  @override
  void initState(){
    super.initState();
    //在加载页面停顿3秒
    new Future.delayed(Duration(seconds: 3),() async {
      print("引导页加载");

      Navigator.pushNamed(context, '/app');
      //NavigatorUtil.goAppPage(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  new GestureDetector(
      child: Image.asset("images/startpage_20190930.jpg",fit: BoxFit.cover,),
      //此处fit:BoxFit.cover用于拉伸图片，使图片铺满全屏
    );

  }

}