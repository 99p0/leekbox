//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <dynamic_color/dynamic_color_plugin.h>
#include <leekbox_infra/leekbox_infra_plugin.h>
#include <leekbox_sdk/leekbox_sdk_plugin.h>
#include <smart_auth/smart_auth_plugin.h>
#include <tflite_flutter/tflite_flutter_plugin.h>
#include <url_launcher_linux/url_launcher_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) dynamic_color_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DynamicColorPlugin");
  dynamic_color_plugin_register_with_registrar(dynamic_color_registrar);
  g_autoptr(FlPluginRegistrar) leekbox_infra_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "LeekboxInfraPlugin");
  leekbox_infra_plugin_register_with_registrar(leekbox_infra_registrar);
  g_autoptr(FlPluginRegistrar) leekbox_sdk_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "LeekboxSdkPlugin");
  leekbox_sdk_plugin_register_with_registrar(leekbox_sdk_registrar);
  g_autoptr(FlPluginRegistrar) smart_auth_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SmartAuthPlugin");
  smart_auth_plugin_register_with_registrar(smart_auth_registrar);
  g_autoptr(FlPluginRegistrar) tflite_flutter_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "TfliteFlutterPlugin");
  tflite_flutter_plugin_register_with_registrar(tflite_flutter_registrar);
  g_autoptr(FlPluginRegistrar) url_launcher_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "UrlLauncherPlugin");
  url_launcher_plugin_register_with_registrar(url_launcher_linux_registrar);
}
