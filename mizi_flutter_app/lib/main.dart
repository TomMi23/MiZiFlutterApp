import 'dart:async';
import 'dart:io';
import 'package:app/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common/global/Storage_Manager.dart';
import 'common/route/Named_Router.dart';

Future main() async {
  // 注册 fluro routes
//  Router router = Router();
//  Routes.configureRoutes(router);
//  Application.router = router;
  await StorageManager.init();

  return   //运行崩溃收集
    runZoned(() {
      //强制横屏
      // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

      /// 强制竖屏
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
          .then((_) {
        runApp(MyApp());

        if (Platform.isAndroid) {
          // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
          SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
          SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
        }
      });
    }, onError: (Object error, StackTrace stack) {
      debugPrint(error.toString());
      debugPrint(stack.toString());
    });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: YStrings.appName,//改这里可以改App的名字
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: new SplashPage(),
      initialRoute: '/',
      routes: NamedRouter.initRoutes(),
      //初始化路由
      //onGenerateRoute: Application.router.generator,
    );
  }
}