package com.doryan.flutter_ml_image_transformation

import androidx.annotation.NonNull
import com.doryan.flutter_ml_image_transformation.channelMethods.CMImageTransform

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

/** FlutterPytorchCoremlCycleganPlugin */
class FlutterPytorchCoremlCycleganPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private val mainScope = CoroutineScope(Dispatchers.Main)

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_ml_image_transformation")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "setModel" -> {
        val params = call.arguments as HashMap<String, *>
        val modelPath = params["modelPath"] as String
        val width = params["inputWidth"] as Int
        val height = params["inputHeight"] as Int
        mainScope.launch {
          result.success(
            CMImageTransform.setModel(modelPath, width, height)
          )
        }
      }
      "transformImage" -> {
        val params = call.arguments as HashMap<String, *>
        val imagePath = params["imagePath"] as String
        val outputPath = params["outputPath"] as String
        mainScope.launch {
          result.success(
            CMImageTransform.transformImage(imagePath, outputPath)
          )
        }
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
