import 'dart:collection';

import 'package:app/config/NavigatorUtil.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyTabPage extends StatefulWidget {
  MyTabPage({Key key}) : super(key: key);

  @override
  _MyTabPageState createState() => _MyTabPageState();
}

class _MyTabPageState extends State<MyTabPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: RaisedButton(
              child: Text('返回，并且返回string'),
              onPressed: () {
                NavigatorUtil.goBackWithParams(context, "我是返回值哦");
              },
            ),
          ),
          RaisedButton(
            child: Text('返回，并且返回int'),
            onPressed: () {
              NavigatorUtil.goBackWithParams(context, 12);
            },
          ),
          RaisedButton(
            child: Text('返回，并且返回double'),
            onPressed: () {
              NavigatorUtil.goBackWithParams(context, 3.1415926);
            },
          ),
          RaisedButton(
            child: Text('返回，并且返回bool'),
            onPressed: () {
              NavigatorUtil.goBackWithParams(context, true);
            },
          ),
          RaisedButton(
            child: Text('访问数据库'),
            onPressed: () async {
//              print("准备参数");
//              var requestParams = {"_GesturePwd":"0","_FingerRegCode":"751a33f29548622321fb23ddc37e3bcc","_IsSimulator":"0","_WeexVersion":0,"_Version":"9.3.0","_BundleVersion":"11","_ANDROID_ID":"f206cd553c71d17a","_DeviceModel":"vivo X6SPlus D","_DeviceId":"862025038108837","_MacValueExt":"7B285D95","_Platform":"android","_TimeStamp":"1587019471422","_SubChannelId":"10000017","_AppVersion":"134","_Guid":"3011b8e15931e2cd74fc4a1f515143c0","_PhoneType":"PD1501BD","_MacWifi":"e0:dd:c0:42:ce:0e","_Manufacturer":"vivo","_IMEI":"862025038108837","_OSVersion":"22","_OriginalDeviceId":"862025038108837","_RefChannelId":"100"};
//
//              debugPrint('请求方式: ' + requestParams.toString());
//
//              Map<String, String>  headerMap = new HashMap();
//              headerMap['Accept'] = 'application/json;charset=utf-8';
//              headerMap['User-Agent'] = 'Lakala Android Client';
//              headerMap['Platform'] = 'android';
//              headerMap['AppVersion'] = '134';
//              headerMap['SubChannelld'] = '10000017';
//              headerMap['BundleVersion'] = '11';
//              headerMap['Content-Type'] = 'application/json; charset=utf-8';
//              headerMap['Host'] = '10.5.31.13:6080';
//              headerMap['Connection'] = 'Keep-Alive';
//              headerMap['Accept-Encoding'] = 'gzip';
//              headerMap['Guid'] = '60cf10daeaf806366edf2f74bbdeb6e6';
//
//              debugPrint('Heard: ' + headerMap.toString());
//
//              debugPrint('**********************************');
//              //httpManager.clearAuthorization();
//
//              var res = await HttpManager.netFetch("http://10.5.31.13:6080/pmobile/common/touchFaceBlackList.do",
//                  requestParams,headerMap,new Options(method: "post"));
            },
          ),

        ],
      ),
    );
  }
}