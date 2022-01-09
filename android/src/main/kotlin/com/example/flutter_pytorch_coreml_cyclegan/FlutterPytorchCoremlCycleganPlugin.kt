package com.example.flutter_pytorch_coreml_cyclegan

import androidx.annotation.NonNull
import com.example.flutter_pytorch_coreml_cyclegan.channelMethods.CMImageTransform

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterPytorchCoremlCycleganPlugin */
class FlutterPytorchCoremlCycleganPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_pytorch_coreml_cyclegan")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "transformImage" -> {
        val params = call.arguments as HashMap<String, *>
        val imagePath = params["imagePath"] as String
        val modelPath = params["modelPath"] as String
        val outputPath = params["outputPath"] as String
        result.success(CMImageTransform.main(imagePath, modelPath, outputPath))
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
