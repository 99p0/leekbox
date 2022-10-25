#import "LeekboxInfraPlugin.h"
#if __has_include(<leekbox_infra/leekbox_infra-Swift.h>)
#import <leekbox_infra/leekbox_infra-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "leekbox_infra-Swift.h"
#endif

@implementation LeekboxInfraPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLeekboxInfraPlugin registerWithRegistrar:registrar];
}
@end
