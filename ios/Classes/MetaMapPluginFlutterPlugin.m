#import "MatiPluginFlutterPlugin.h"
#if __has_include(<mati_plugin_flutter/mati_plugin_flutter-Swift.h>)
#import <mati_plugin_flutter/mati_plugin_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "mati_plugin_flutter-Swift.h"
#endif

@implementation MatiPluginFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMetaMapPluginFlutterPlugin registerWithRegistrar:registrar];
}
@end
