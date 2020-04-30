package mizi.flutter.app.plugin;

import android.Manifest;
import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.app.Activity;
import android.app.AlertDialog;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.widget.Toast;


import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * 实现Flutter与Android Native端通信插件 这个主要是蓝牙相关插件
 *
 * */
public class FlutterPluginJumpToBluetooth implements MethodChannel.MethodCallHandler{
    public static String CHANNEL = "mizi.flutter.app/bluetooth";


    private BluetoothManager bluetoothManager = null;	 //初始化
    private BluetoothAdapter bluetoothAdapter = null;	//蓝牙适配器


    Activity activity;

    static MethodChannel channel;

    private FlutterPluginJumpToBluetooth(Activity activity) {
        this.activity = activity;
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        channel = new MethodChannel(registrar.messenger(), CHANNEL);
        FlutterPluginJumpToBluetooth instance = new FlutterPluginJumpToBluetooth(registrar.activity());
        //setMethodCallHandler在此通道上接收方法调用的回调
        channel.setMethodCallHandler(instance);
    }


    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if(methodCall.method.equals("openBuleTooth")){	//判断flutter调用那个方法
            if(supportBuleTooth()){						//检测真机是否支持蓝牙
                openBuleTooth();							//打开蓝牙
                result.success("蓝牙已经被开启");
            }else{
                result.error("设备不支持蓝牙",null,null);
            }
        }
        else if(methodCall.method.equals("getBuleTooth")){
            if(supportBuleTooth()){
                if(disabled()){								//检测蓝牙的状态
                    result.success("蓝牙已经开启");
                }else{
                    result.success("蓝牙未开启");
                }
            }
        }
    }

    //是否支持蓝牙

    private boolean supportBuleTooth(){
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
            bluetoothManager=(BluetoothManager)activity.getSystemService(Context.BLUETOOTH_SERVICE);
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
            bluetoothAdapter=bluetoothManager.getAdapter();
        }
        if (bluetoothAdapter==null){    //不支持蓝牙
            return false;
        }
        return true;
    }

    //打开蓝牙
    private void openBuleTooth(){
        //判断蓝牙是否开启
        Intent enabler=new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
        activity.startActivityForResult(enabler,1);
    }

    //判断蓝牙是否已经开启
    private boolean disabled(){
        if(bluetoothAdapter.isEnabled()){
            return true;
        }
        return false;
    }
}
