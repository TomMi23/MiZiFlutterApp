import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BluetoothPage extends StatefulWidget {
  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  String _message='检查蓝牙状态中....';
///////////Flutter 调用原生 Start//////////////
  static const MethodChannel methodChannel=
  MethodChannel('mizi.flutter.app/bluetooth');

  Future<void> _openBlueTooth()async{
    String message;
    message=await methodChannel.invokeMethod('openBuleTooth');
    setState(() {
      _message=message;
    });
  }

  Future<void> _getBlueTooth()async{
    String message;
    message=await methodChannel.invokeMethod('getBuleTooth');
    setState(() {
      _message=message;
    });
  }

  //////// Flutter 调用原生  End  ////////

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("蓝牙"),
      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('蓝牙状态:'),
                    Text(
                      _message,
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Column(
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: Text('打开蓝牙'),
                          onPressed: _openBlueTooth,
                        ),
                        RaisedButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: Text('检测蓝牙状态'),
                          onPressed: _getBlueTooth,
                        ),
                      ],
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}