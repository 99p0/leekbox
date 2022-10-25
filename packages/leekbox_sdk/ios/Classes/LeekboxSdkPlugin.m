#import "LeekboxSdkPlugin.h"
#if __has_include(<leekbox_sdk/leekbox_sdk-Swift.h>)
#import <leekbox_sdk/leekbox_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "leekbox_sdk-Swift.h"
#endif

@implementation LeekboxSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLeekboxSdkPlugin registerWithRegistrar:registrar];
}
@end
