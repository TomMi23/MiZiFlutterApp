import 'dart:collection';

import 'package:app/common/local/LocalStorage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Code.dart';
import 'Config.dart';
import 'NavigationService.dart';
import 'ResultData.dart';

///http请求
class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  NavigationService navigationService =new NavigationService();

  static Map optionParams = {
    "timeoutMs": 15000,
    "token":
    'Venus eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMzcyMDMzMDc4NCIsImNyZWF0ZWRfZGF0ZSI6MTUzMzc4MTk1NTM1MSwiZXhwIjoxNTM2MzczOTU1LCJqdGkiOjE0NTl9.lsAV8LvTw4AmnqX2j7hr9mLljiwkMqcAjTGV1NJ9LcGsEQwJu176rV6alaH5P4BvnvQKHQYh2HZ_IhqRe4jvwA',
    "authorizationCode":
    'Venus eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMzcyMDMzMDc4NCIsImNyZWF0ZWRfZGF0ZSI6MTUzMzc4MTk1NTM1MSwiZXhwIjoxNTM2MzczOTU1LCJqdGkiOjE0NTl9.lsAV8LvTw4AmnqX2j7hr9mLljiwkMqcAjTGV1NJ9LcGsEQwJu176rV6alaH5P4BvnvQKHQYh2HZ_IhqRe4jvwA',
  };

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  static netFetch(url, params, Map<String, String> header, Options option,
      {noTip = false}) async {
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return new ResultData(
          Code.errorHandleFunction(Code.NETWORK_ERROR, "", noTip),
          false,
          Code.NETWORK_ERROR);
    }

    Map<String, String> headers = new HashMap();
    headers['Accept'] = Config.ACCEPT;
    headers['User-Agent'] = 'Android Client';//这里通过全局变量或者从Native端取
    headers['Platform'] = 'android';//这里通过全局变量或者从Native端取
    headers['AppVersion'] = '134';//这里通过全局变量或者从Native端取
    headers['SubChannelld'] = '10000017';//这里通过全局变量或者从Native端取
    headers['BundleVersion'] = '11';//这里通过全局变量或者从Native端取
    headers['Content-Type'] = Config.CONTENT_TYPE;
    headers['Host'] = '10.5.31.13:6080';//这里通过全局变量或者从Native端取
    headers['Connection'] = Config.CONNECTION;
    headers['Accept-Encoding'] = Config.ACCEPT_ENCODING;
    headers['Guid'] = '60cf10daeaf806366edf2f74bbdeb6e6';//这里通过全局变量或者从Native端取
    if (header != null) {
      headers.addAll(header);
    }

    //授权码
//    if (optionParams["authorizationCode"] == null) {
//      var authorizationCode = await getAuthorization();
//      if (authorizationCode != null) {
//        optionParams["authorizationCode"] = authorizationCode;
//      }
//    }
//
//    headers["Authorization"] = optionParams["authorizationCode"];

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }

    Dio dio = new Dio();
    //拦截器部分
    //两种方法均可
    //dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) => requestInterceptor(options)));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options){
      debugPrint('请求方式: ' + options.method);
      debugPrint('请求url: ' + options.path);
      debugPrint('请求头: ' + option.headers.toString());
      if (params != null) {
        debugPrint('请求参数: ' + params.toString());
      }
      if (optionParams["authorizationCode"] != null) {
        debugPrint('authorizationCode: ' + optionParams["authorizationCode"]);
      }
      // 在请求被发送之前做一些事情
      // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }));


    //两种方法均可
    //dio.interceptors.add(InterceptorsWrapper(onResponse:(Response response) => responseInterceptor(response)));
    dio.interceptors.add(InterceptorsWrapper(onResponse: (Response response){
      if (response != null) {
        debugPrint('返回参数: ' + response.toString());
      }
    }));

    //两种方法均可
    //dio.interceptors.add(InterceptorsWrapper(onError: (DioError dioError) => errorInterceptor(dioError)));
    dio.interceptors.add(InterceptorsWrapper(onError: (DioError dioError) {
      // 当请求失败时做一些预处理
      debugPrint('请求异常: ' + dioError.toString());
    }));


    Response response;
    try {
      response = await dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      return new ResultData(
          Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip),
          false,
          errorResponse.statusCode);
    }

    try {
      if (option.contentType != null &&
          option.contentType.primaryType == "text") {
        return new ResultData(response.data, true, Code.SUCCESS);
      } else {
        var responseJson = response.data;
        if (response.statusCode == 201 && responseJson["token"] != null) {
          optionParams["authorizationCode"] = 'token ' + responseJson["token"];
          await LocalStorage.save(
              Config.TOKEN_KEY, optionParams["authorizationCode"]);
        }
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return new ResultData(response.data, true, Code.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + url);
      return new ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }
    return new ResultData(
        Code.errorHandleFunction(response.statusCode, "", noTip),
        false,
        response.statusCode);
  }

  ///清除授权
  static clearAuthorization() {
    optionParams["authorizationCode"] = null;
    LocalStorage.remove(Config.TOKEN_KEY);
  }

  ///获取授权token
  static getAuthorization() async {
    String token = await LocalStorage.get(Config.TOKEN_KEY);
    if (token == null) {
      String basic = await LocalStorage.get(Config.USER_BASIC_CODE);
      if (basic == null) {
        //提示输入账号密码
      } else {
        //通过 basic 去获取token，获取到设置，返回token
        return "Basic $basic";
      }
    } else {
      optionParams["authorizationCode"] = token;
      return token;
    }
  }

  static errorInterceptor(DioError dioError) {
    //可以判断一些错误码
    if (dioError.message.contains("ERROR_001")) {
      // 当请求失败时做一些预处理
      debugPrint('请求异常: ' + dioError.toString());
      //也可以做一些跳转
      //navigationService.pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
    }
    return dioError;
  }

  static responseInterceptor(Response options) {
    if (options.headers.value("verifyToken") != null) {
      //if the header is present, then compare it with the Shared Prefs key
      SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;
      var verifyToken = prefs.get("VerifyToken");

      // if the value is the same as the header, continue with the request
      if (options.headers.value("verifyToken") == verifyToken) {
        return options;
      }
    }

    return DioError(request: options.request, message: "User is no longer active");
  }

  static requestInterceptor(RequestOptions options) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");

    options.headers.addAll({"Token": "$token${DateTime.now()}"});

    return options;
  }

}
