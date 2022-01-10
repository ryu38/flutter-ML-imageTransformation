
import 'dart:async';

import 'package:flutter/services.dart';

class MLImageTransformer {
  static const MethodChannel _channel = MethodChannel('flutter_ml_image_transformation');

  static Future<String?> setModel({
    required String modelPath,
    int inputWidth = 256,
    int inputHeight = 256,
  }) async {
    final params = <String, dynamic>{
      'modelPath': modelPath,
      'inputWidth': inputWidth,
      'inputHeight': inputHeight
    };
    final String? errorMessage = await _channel.invokeMethod('setModel', params);
    return errorMessage;
  }

  static Future<String?> transformImage({
    required String imagePath,
    required String outputPath,
  }) async {
    final params = <String, dynamic>{
      'imagePath': imagePath,
      'outputPath': outputPath,
    };
    final String? errorMessage = await _channel.invokeMethod('transformImage', params);
    return errorMessage;
  }
}
