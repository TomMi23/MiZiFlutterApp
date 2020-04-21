package mizi.flutter.app.plugin;
import android.annotation.TargetApi;
import android.app.Activity;
import android.os.Build;
import android.provider.Settings;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import mizi.flutter.app.util.DeviceUtils;
import mizi.flutter.app.util.StringUtils;

/**
 * 实现Flutter与Android Native端通信插件
 *
 * */
public class FlutterPluginJumpToAct implements MethodChannel.MethodCallHandler {
    public static String CHANNEL = "mizi.flutter.app/plugin";

    Activity activity;

    static MethodChannel channel;

    private FlutterPluginJumpToAct(Activity activity) {
        this.activity = activity;
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        channel = new MethodChannel(registrar.messenger(), CHANNEL);
        FlutterPluginJumpToAct instance = new FlutterPluginJumpToAct(registrar.activity());
        //setMethodCallHandler在此通道上接收方法调用的回调
        channel.setMethodCallHandler(instance);
    }


    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        //通过MethodCall可以获取参数和方法名，然后再寻找对应的平台业务，本案例做了2个跳转的业务

        //接收来自flutter的指令oneAct
        if (methodCall.method.equals("oneAct")) {

//            //跳转到指定Activity
//            Intent intent = new Intent(activity, OneActivity.class);
//            activity.startActivity(intent);
//
//            //返回给flutter的参数
            result.success(DeviceUtils.getAndroidId(activity));
        }
        //接收来自flutter的指令twoAct
        else if (methodCall.method.equals("twoAct")) {

            //解析参数
//            String text = methodCall.argument("flutter");
//
//            //带参数跳转到指定Activity
//            Intent intent = new Intent(activity, TwoActivity.class);
//            intent.putExtra(TwoActivity.VALUE, text);
//            activity.startActivity(intent);
//
//            //返回给flutter的参数
//            result.success("success");
        }
        else {
            result.notImplemented();
        }
    }


}
