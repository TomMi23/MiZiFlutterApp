
import 'package:flutter/material.dart';
import 'Routes.dart';
import 'application.dart';

class NavigatorUtil {
  /// 跳转到首页主界面
  static void goHomePage(BuildContext context) {
    /// replace：true 就是将 splash 页面给移除掉了，这点后退键的时候就不会再出现Splash页面
    Application.router.navigateTo(context, Routes.homeTab, replace: true);
  }

  /// 跳转到登录页面
  static void gologinPage(BuildContext context) {
    /// replace：true 就是将 splash 页面给移除掉了，这点后退键的时候就不会再出现Splash页面

//    Navigator.pushNamed(context, Routes.login);
//    Navigator.push(context, MaterialPageRoute(builder: (context) {
//      return LoginPage();
//    }));
    Application.router.navigateTo(context, Routes.login, replace: true);
  }

  /// 跳转到App主页面
  static void goAppPage(BuildContext context) {
    /// replace：true 就是将 splash 页面给移除掉了，这点后退键的时候就不会再出现Splash页面
    Application.router.navigateTo(context, Routes.app, replace: true);

  }
  /// 跳转到地图GPS页面
  static void goMapGPSPage(BuildContext context) {
    Application.router.navigateTo(context, Routes.mapGPS, replace: true);
  }
  /// 跳转到Google地图页面
  static void goGoogleMapPage(BuildContext context) {
    Application.router.navigateTo(context, Routes.googleMap, replace: true);
  }

  /// 返回
  static void goBack(BuildContext context) {
    /// 其实这边调用的是 Navigator.pop(context);
    //Navigator.pop(context);
    Application.router.pop(context);
  }

  /// 带参数的返回
  static void goBackWithParams(BuildContext context, result) {
    Navigator.pop(context, result);
  }
}