import Flutter
import UIKit

public class SwiftFlutterPytorchCoremlCycleganPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_pytorch_coreml_cyclegan", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterPytorchCoremlCycleganPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
