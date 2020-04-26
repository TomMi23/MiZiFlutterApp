import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MapGPSPage extends StatefulWidget {
  @override
  _MapGPSPageState createState() => _MapGPSPageState();
}

class _MapGPSPageState extends State<MapGPSPage> {
  ///////////Flutter 调用原生 Start//////////////

  static const MethodChannel methodChannel= MethodChannel('mizi.flutter.app/gps');
  String _message;
  Future<void> _inspection()async{
    String message;
    message=await methodChannel.invokeMethod('inspectionGPS');
    setState(() {
      _message=message;
    });
  }

  Future<void> _open()async{
    await methodChannel.invokeMethod('openGPS');
  }

  Future<void> _getDate() async{
    await methodChannel.invokeMethod('getDate');
  }
  //////// Flutter 调用原生  End  ////////


  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}