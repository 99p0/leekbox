#ifndef FLUTTER_PLUGIN_LEEKBOX_SDK_PLUGIN_H_
#define FLUTTER_PLUGIN_LEEKBOX_SDK_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace leekbox_sdk {

class LeekboxSdkPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  LeekboxSdkPlugin();

  virtual ~LeekboxSdkPlugin();

  // Disallow copy and assign.
  LeekboxSdkPlugin(const LeekboxSdkPlugin&) = delete;
  LeekboxSdkPlugin& operator=(const LeekboxSdkPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace leekbox_sdk

#endif  // FLUTTER_PLUGIN_LEEKBOX_SDK_PLUGIN_H_
