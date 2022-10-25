//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <leekbox_infra/leekbox_infra_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) leekbox_infra_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "LeekboxInfraPlugin");
  leekbox_infra_plugin_register_with_registrar(leekbox_infra_registrar);
}
