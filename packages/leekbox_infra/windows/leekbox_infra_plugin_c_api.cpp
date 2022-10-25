#include "include/leekbox_infra/leekbox_infra_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "leekbox_infra_plugin.h"

void LeekboxInfraPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  leekbox_infra::LeekboxInfraPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
