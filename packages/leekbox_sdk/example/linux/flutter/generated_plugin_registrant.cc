//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <leekbox_sdk/leekbox_sdk_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) leekbox_sdk_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "LeekboxSdkPlugin");
  leekbox_sdk_plugin_register_with_registrar(leekbox_sdk_registrar);
}
