import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'Route_Handler.dart';

class Routes {
  static String root = "/";
  static String homeTab = "/HomeTabPage";
  static String splashPage = "/SplashPage";
  static String app = "/app";
  static String login = "/LoginPage";
  static String mapGPS = "/MapGPSPage";
  static String googleMap = "/GoogleMapPage";

  static void configureRoutes(Router router) {
    // 检测如果没有匹配到路由
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          // ignore: missing_return, missing_return
          print("ROUTE WAS NOT FOUND !!!");
        });

    /// 第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是默认的转场动画
    router.define(homeTab, handler: homeTabHandler);
    router.define(splashPage, handler: splashHandler);
    router.define(app, handler: appHandler);
    router.define(login, handler: loginHandler);
    router.define(mapGPS, handler: mapGPSHandler);
    router.define(googleMap, handler: googleMapHandler);

  }
}