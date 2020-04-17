import 'package:app/res/strings.dart';
import 'package:flutter/material.dart';

import 'common/route/Named_Router.dart';

Future main() async {
  // 注册 fluro routes
//  Router router = Router();
//  Routes.configureRoutes(router);
//  Application.router = router;


  return runApp(MyApp());
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