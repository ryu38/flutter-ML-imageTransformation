import Flutter
import UIKit

public class SwiftFlutterPytorchCoremlCycleganPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "flutter_pytorch_coreml_cyclegan",
            binaryMessenger: registrar.messenger()
        )
        let instance = SwiftFlutterPytorchCoremlCycleganPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "convertImage":
            let params = call.arguments as! Dictionary<String, Any>
            let imagePath = params["imagePath"] as! String
            let modelPath = params["modelPath"] as! String
            let outputPath = params["outputPath"] as! String
            result(CMImageTransform.main(
                imagePath: imagePath, modelPath: modelPath, outputPath: outputPath))
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
