import 'package:app/page/view_models/User_Model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Store {
  //  初始化
  static init({Widget child}) {
    /// 返回多个状态
    return MultiProvider(
      providers: [
        // ignore: deprecated_member_use
        ChangeNotifierProvider(create: (_) => UserModel()),

      ],
      child: child,
    );
  }

  //  通过Provider.value<T>(context)获取状态数据
  static T value<T>(BuildContext context) {
    return Provider.of(context);
  }

  //  通过Consumer获取状态数据
  static Consumer connect<T>(
      {Function(BuildContext context, T value, Widget child) builder,
        Widget child}) {
    return Consumer<T>(builder: builder, child: child);
  }

  //  通过Consumer获取状态数据
  static Consumer2 connect2<A, B>(
      {Function(BuildContext context, A value, B value2, Widget child) builder,
        Widget child}) {
    return Consumer2<A, B>(builder: builder, child: child);
  }
}
