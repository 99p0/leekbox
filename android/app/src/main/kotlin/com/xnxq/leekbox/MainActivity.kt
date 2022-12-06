package com.xnxq.leekbox

import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

  // 通讯名称,回到手机桌面
  private val channel = "android/back/desktop"
  private val backDesktopMethod = "backDesktop"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine)
    // 回到手机桌面
    initMethodChannelForBackDesktop()
  }

  /**
   * 回到手机桌面
   */
  private fun initMethodChannelForBackDesktop() {
    flutterEngine?.let {
      MethodChannel(
        it.dartExecutor,
        channel
      ).setMethodCallHandler { methodCall, result ->
        if (backDesktopMethod == methodCall.method) {
          result.success(true)
          moveTaskToBack(false)
        }
      }
    }
  }

  /**
   * 设置状态栏沉浸式透明（修改flutter状态栏黑色半透明为全透明）
   */
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      window.statusBarColor = 0
    }
    // 初始化 TalkingData
    // TalkingDataSDKPlugin.init(
    //     applicationContext,
    //     "44B497C865CD46769E7A3D8FE2DC8E35",
    //     "Huawei",
    //     "ko"
    // );
    // 初始化 友盟+
    // UMConfigure.preInit(this,"5e3f96f3cb23d2a070000048","Umeng");
    // UMConfigure.setLogEnabled(true);
    // 动态配置 max_aspect，保证手机正常占满窗口。
    // setMaxAspect((DensityUtil.getScreenWidth() as Double / DensityUtil.getScreenHeight()).toString() + "")
  }

  fun setMaxAspect(max_aspect: String?) {
    var applicationInfo: ApplicationInfo? = null
    try {
      applicationInfo = packageManager.getApplicationInfo(
        packageName,
        PackageManager.GET_META_DATA
      )
    } catch (e: PackageManager.NameNotFoundException) {
      e.printStackTrace()
    }
    requireNotNull(applicationInfo) { "get application info = null " }
    applicationInfo.metaData.putString("android.max_aspect", max_aspect)
  }
}
