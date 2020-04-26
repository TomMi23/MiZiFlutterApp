package mizi.flutter.app;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;
import mizi.flutter.app.plugin.FlutterPluginJumpToAct;
import mizi.flutter.app.plugin.FlutterPluginJumpToGPS;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    GeneratedPluginRegistrant.registerWith(this);
    registerCustomPlugin(this);
  }

  private static void registerCustomPlugin(PluginRegistry registrar) {

    FlutterPluginJumpToAct.registerWith(registrar.registrarFor(FlutterPluginJumpToAct.CHANNEL));
    FlutterPluginJumpToGPS.registerWith(registrar.registrarFor(FlutterPluginJumpToGPS.CHANNEL));
    //FlutterPluginJumpToAct.registerWith(registrar.registrarFor(FlutterPluginJumpToAct.CHANNEL));
  }
}
