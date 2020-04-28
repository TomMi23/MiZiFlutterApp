
//import 'package:app_jdq_flutter/app.dart';
//import 'package:app_jdq_flutter/page/loginPage.dart';
//import 'package:app_jdq_flutter/page/yifenqiPage.dart';
//import 'package:app/page/gmap/GoogleMapPage.dart';
//import 'package:app/page/gmap/MapGPSPage.dart';
import 'package:app/page/login/LoginPage.dart';
import 'package:app/page/main/HomeTabPage.dart';
import 'package:app/page/splash/SplashPage.dart';
import 'package:app/page/main/app.dart';
import 'package:flutter/material.dart';

class NamedRouter {
  static Map<String, WidgetBuilder> routes;
//初始化App
  static Widget initApp() {
    return MaterialApp(
      initialRoute: '/',
      routes: NamedRouter.initRoutes(),
    );
  }

  //初始化路由
  static initRoutes() {
    routes = {
      '/': (context) => SplashPage(),
      '/app': (context) => App(),
      '/splashPage': (context) => SplashPage(),
      '/homeTabPage': (context) => HomeTabPage(),
      '/loginPage': (context) => LoginPage(),
//      '/mapGPSPage': (context) => MapGPSPage(),
//      '/googleMapPage': (context) => GoogleMapPage(),
    };
    return routes;
  }

}