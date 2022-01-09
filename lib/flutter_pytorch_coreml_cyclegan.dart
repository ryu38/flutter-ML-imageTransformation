
import 'dart:async';

import 'package:flutter/services.dart';

class GANImageConverter {
  static const MethodChannel _channel = MethodChannel('flutter_pytorch_coreml_cyclegan');

  static Future<bool> transformImage(String imagePath, String modelPath, String outputPath) async {
    final params = <String, dynamic>{
      'imagePath': imagePath,
      'modelPath': modelPath,
      'outputPath': outputPath,
    };
    final String? errorMessage = await _channel.invokeMethod('transformImage', params);
    if (errorMessage != null) {
      print(errorMessage);
      return false;
    } else {
      print("no error");
      return true;
    }
  }
}
