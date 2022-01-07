
import 'dart:async';

import 'package:flutter/services.dart';

class GANImageConverter {
  static const MethodChannel _channel = MethodChannel('flutter_pytorch_coreml_cyclegan');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> convertImage(String imagePath, String modelPath, String outputPath) async {
    final params = <String, dynamic>{
      'imagePath': imagePath,
      'modelPath': modelPath,
      'outputPath': outputPath,
    };
    final bool? result = await _channel.invokeMethod('convertImage', params);
    return result ?? false;
  }
}
