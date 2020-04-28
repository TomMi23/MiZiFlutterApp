//import 'package:app/page/gmap/GoogleMapPage.dart';
//import 'package:app/page/gmap/MapGPSPage.dart';
import 'package:app/page/login/LoginPage.dart';
import 'package:app/page/main/HomeTabPage.dart';
import 'package:app/page/main/MyTabPage.dart';
import 'package:app/page/splash/SplashPage.dart';
import 'package:app/page/main/app.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

/// 跳转到首页
var homeTabHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new HomeTabPage();
    });

/// 跳转到我的
var myPageTabHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new MyTabPage();
    });

/// 跳转到应用首页
var appHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new App();
    });

/// 跳转到登录页
var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new LoginPage();
    });

/// 跳转到splashPage页
var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new SplashPage();
    });

/// MapGPSPage
//var mapGPSHandler = new Handler(
//    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//      return new MapGPSPage();
//    });
/// 跳转到GoogleMapPage页
//var googleMapHandler = new Handler(
//    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//      return new GoogleMapPage();
//    });


