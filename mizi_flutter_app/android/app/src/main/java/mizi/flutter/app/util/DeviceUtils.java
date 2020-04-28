package mizi.flutter.app.util;

import android.Manifest;
import android.annotation.TargetApi;
import android.app.PendingIntent;
import android.app.PendingIntent.CanceledException;
import android.bluetooth.BluetoothAdapter;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.LocationManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.os.Environment;
import android.provider.Settings;
import android.telephony.TelephonyManager;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;


import java.io.IOException;

import io.reactivex.Observable;
import io.reactivex.ObservableEmitter;
import io.reactivex.ObservableOnSubscribe;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by Vinchaos api on 13-12-12.
 * 设备信息工具类
 */
public class DeviceUtils {

    private static final String CMCC_ISP = "46000";//中国移动
    private static final String CMCC2_ISP = "46002";//中国移动
    private static final String CU_ISP = "46001";//中国联通
    private static final String CT_ISP = "46003";//中国电信
    private static String android_ID;

    /**
     * getIMEI
     * 获取IMEI
     *
     * @return
     */
    @TargetApi(Build.VERSION_CODES.M)
    @Deprecated
    public static String getIMEI(@NonNull Context context) {
        TelephonyManager manager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);

        if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.LOLLIPOP_MR1) {
            if (ActivityCompat.checkSelfPermission(context, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
                // TODO: Consider calling
                //    ActivityCompat#requestPermissions
                // here to request the missing permissions, and then overriding
                //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                //                                          int[] grantResults)
                // to handle the case where the user grants the permission. See the documentation
                // for ActivityCompat#requestPermissions for more details.
                return "";
            }
            String imei = manager.getDeviceId();
            return imei == null ? "" : imei;
        }

        if (context.checkSelfPermission(Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
            return "";
        } else {
            String imei = manager.getDeviceId();
            return imei == null ? "" : imei;
        }
    }

    /**
     * getIMSI
     *
     * @return
     */
    @TargetApi(Build.VERSION_CODES.M)
    public static String getIMSI(@NonNull Context context) {
        TelephonyManager manager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);

        if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.LOLLIPOP_MR1) {
            if (ActivityCompat.checkSelfPermission(context, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
                // TODO: Consider calling
                //    ActivityCompat#requestPermissions
                // here to request the missing permissions, and then overriding
                //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                //                                          int[] grantResults)
                // to handle the case where the user grants the permission. See the documentation
                // for ActivityCompat#requestPermissions for more details.
                return "";
            }
            String imsi = manager.getSubscriberId();
            return imsi == null ? "" : imsi;
        }

        if (context.checkSelfPermission(Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
            return "";
        } else {
            String imsi = manager.getSubscriberId();
            return imsi == null ? "" : imsi;
        }
    }

    /**
     * getMac
     * 获取Mac地址
     *
     * @return
     */
    public static String getMac(@NonNull Context context) {
        WifiManager wifi = (WifiManager) context.getApplicationContext().getSystemService(Context.WIFI_SERVICE);
        boolean canGetConnectionInfo = wifi != null && wifi.isWifiEnabled();
        if (canGetConnectionInfo) {
            WifiInfo info = wifi.getConnectionInfo();
            return info == null ? "" : info.getMacAddress();
        }
        return "";
    }

    /**
     * @return bluetooth mac address
     */
    public static String getBlueMac() {
        BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        boolean canGetMac = bluetoothAdapter != null && bluetoothAdapter.isEnabled();
        return canGetMac ? bluetoothAdapter.getAddress() : "";
    }

    /**
     * 获取手机网络运营商类型
     *
     * @return
     */
    public static String getPhoneISP(@NonNull Context context) {
        TelephonyManager manager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
        String teleCompany = "";
        String np = manager.getNetworkOperator();
        if (np != null) {
            if (np.equals(CMCC_ISP) || np.equals(CMCC2_ISP)) {
                //中国移动
                teleCompany = "y";
            } else if (np.startsWith(CU_ISP)) {
                //中国联通
                teleCompany = "l";
            } else if (np.startsWith(CT_ISP)) {
                //中国电信
                teleCompany = "d";
            }
        }
        teleCompany = StringUtils.trim(teleCompany);
        return teleCompany;
    }

    /**
     * 获取手机标识
     *
     * @return
     */
    public static String getPhoneModel() {
        return StringUtils.trim(Build.MODEL);
    }


    /**
     * getPhoneManufacturer
     * 获取手机厂商
     *
     * @return
     */
    public static String getPhoneManufacturer() {
        String phoneManufacturer;
        // eg:motorola
        phoneManufacturer = Build.MANUFACTURER;
        phoneManufacturer = StringUtils.trim(phoneManufacturer);
        return phoneManufacturer;
    }

    /**
     * getPhoneType
     * 获取手机型号
     *
     * @return
     */
    public static String getPhoneType() {
        String phoneType;
        // eg:ME860_HKTW
        phoneType = Build.PRODUCT;
        phoneType = StringUtils.trim(phoneType);
        return phoneType;
    }

    /**
     * getPhoneOSVersion
     * 获取系统版本
     *
     * @return
     */
    public static String getPhoneOSVersion() {
        String osVersion;
        osVersion = String.valueOf(Build.VERSION.SDK_INT);
        osVersion = StringUtils.trim(osVersion);
        return osVersion;
    }

    /**
     * 检查gps是否可用
     *
     * @return
     */
    public static boolean isGpsAvaiable(@NonNull Context context) {
        LocationManager locationManager = (LocationManager) context.getSystemService(Context.LOCATION_SERVICE);
        boolean isEnabled = locationManager
                .isProviderEnabled(LocationManager.GPS_PROVIDER);
        return isEnabled;
    }

    /**
     * 打开gps和关闭gps
     *
     * @param context
     */
    public static void autoGps(@NonNull Context context) {
        try {
            Intent GPSIntent = new Intent();// 代码自动打开gps
            GPSIntent.setClassName("com.android.settings",
                    "com.android.settings.widget.SettingsAppWidgetProvider");
            GPSIntent.addCategory("android.intent.category.ALTERNATIVE");
            GPSIntent.setData(Uri.parse("custom:3"));
            PendingIntent.getBroadcast(context, 0, GPSIntent, 0).send();
        } catch (CanceledException e) {
        }
    }

    /**
     * 网络是否可用
     *
     * @return true可用 </br> false不可用
     */
    public static boolean isNetworkAvailable(@NonNull Context context) {
        ConnectivityManager connectivity = (ConnectivityManager) context
                .getSystemService(Context.CONNECTIVITY_SERVICE);
        if (connectivity == null) {
            return false;
        } else {
            NetworkInfo info = connectivity.getActiveNetworkInfo();
            if (info != null && info.isAvailable()) {
                int type = info.getType();
                if (type == ConnectivityManager.TYPE_WIFI || type == ConnectivityManager.TYPE_MOBILE) {
                    return true;
                }
            }
        }
        return false;
    }


    /**
     * 得到设备的广告id,广告id可被用户重置,
     * @return
     */
    @TargetApi(Build.VERSION_CODES.CUPCAKE)
    public static String getAndroidId(@NonNull Context context){
        String android_ID="";
        if (StringUtils.isNotEmpty(android_ID)){
            return android_ID;
        }

        android_ID = Settings.Secure.getString(context.getContentResolver(), Settings.Secure.ANDROID_ID);
        return android_ID;
    }

    /**
     * 获取sim卡 手机号码
     * @param context
     * @return
     */
    @TargetApi(Build.VERSION_CODES.M)
    public static String getSimPhoneNumber(@NonNull Context context) {
        TelephonyManager manager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);

        if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.LOLLIPOP_MR1) {
            if (ActivityCompat.checkSelfPermission(context, Manifest.permission.READ_SMS) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(context, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
                // TODO: Consider calling
                //    ActivityCompat#requestPermissions
                // here to request the missing permissions, and then overriding
                //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                //                                          int[] grantResults)
                // to handle the case where the user grants the permission. See the documentation
                // for ActivityCompat#requestPermissions for more details.
                return "";
            }
            return manager.getLine1Number();
        }

        if (context.checkSelfPermission(Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED){
            return "";
        }else {
            return manager.getLine1Number();
        }
    }

    /**
     * 获取SD卡路径
     *
     * @return SD卡存储路径
     */
    public static String getSDCardPath() {
        if (sdCardAvailable())
            return Environment.getExternalStorageDirectory().getPath();
        else
            return "";
    }

    /**
     * 判断sd卡是否存在
     *
     * @return true 存在   </br>  flase  未安装SD卡
     */
    public static boolean sdCardAvailable() {
        String state = Environment.getExternalStorageState();
        if (Environment.MEDIA_MOUNTED.equals(state)) {
            return true;
        } else return Environment.MEDIA_MOUNTED_READ_ONLY.equals(state);
    }
}

