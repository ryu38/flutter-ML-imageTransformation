import Flutter
import UIKit

public class SwiftFlutterPytorchCoremlCycleganPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "flutter_ml_image_transformation",
            binaryMessenger: registrar.messenger()
        )
        let instance = SwiftFlutterPytorchCoremlCycleganPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setModel":
            let params = call.arguments as! Dictionary<String, Any>
            let modelPath = params["modelPath"] as! String
            let width = params["inputWidth"] as! Int
            let height = params["inputHeight"] as! Int
            result(CMImageTransform.setModel(
                modelPath: modelPath, width: width, height: height
            ))
        case "transformImage":
            let params = call.arguments as! Dictionary<String, Any>
            let imagePath = params["imagePath"] as! String
            let outputPath = params["outputPath"] as! String
            result(CMImageTransform.transformImage(
                imagePath: imagePath, outputPath: outputPath
            ))
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
