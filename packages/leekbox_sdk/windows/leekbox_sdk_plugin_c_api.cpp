#include "include/leekbox_sdk/leekbox_sdk_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "leekbox_sdk_plugin.h"

void LeekboxSdkPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  leekbox_sdk::LeekboxSdkPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
