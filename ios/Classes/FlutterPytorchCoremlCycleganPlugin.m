#import "FlutterPytorchCoremlCycleganPlugin.h"
#if __has_include(<flutter_ml_image_transformation/flutter_ml_image_transformation-Swift.h>)
#import <flutter_ml_image_transformation/flutter_ml_image_transformation-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_ml_image_transformation-Swift.h"
#endif

@implementation FlutterPytorchCoremlCycleganPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPytorchCoremlCycleganPlugin registerWithRegistrar:registrar];
}
@end
