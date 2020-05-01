import 'package:app/services/ScreenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:amap_location/amap_location.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';

///调用高德地图可能会因为Key报错，在测试环境已经成功
class GpsPage extends StatefulWidget{
  GpsPage({Key key});
  _GpsPageState createState() => _GpsPageState();
}

class _GpsPageState extends State<GpsPage> {
  double longitude = 0.0;
  double latitude = 0.0;

  @override
  void initState() {
    super.initState();
    this._getLocation();

  }

  _getLocation() async {
    print("调用高德地图可能会因为Key报错，在测试环境已经成功");
    //启动一下
    await AMapLocationClient.startup(new AMapLocationOption(
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyBest));
    //获取地理位置（直接定位）
    var result = await AMapLocationClient.getLocation(true);
    setState(() {
      this.longitude = result.longitude; //经度
      this.latitude = result.latitude; //纬度
    });
  }

  @override
  void dispose() {
    //停止监听定位、销毁定位
    AMapLocationClient.stopLocation();
    AMapLocationClient.shutdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //这个方法得在initState()之后调用
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("获取位置信息"),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: RaisedButton(
              child: Text("获取位置"),
              onPressed: () {
                _getLocation();
              },
            ),
          ),
          Text("经度：${this.longitude}"),
          Text("纬度：${this.latitude}"),
          //显示地图
          Container(
            width: double.infinity,
            height: ScreenAdapter.height(300.0),
            child: Stack(
              children: <Widget>[
                AmapView(
                  mapType: MapType.Standard,
                  showZoomControl: false,
                  zoomLevel: 15,
                  centerCoordinate: LatLng(this.latitude, this.longitude),
                  onMapCreated: (controller) async {
                    await controller.showMyLocation(MyLocationOption(show: true));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}