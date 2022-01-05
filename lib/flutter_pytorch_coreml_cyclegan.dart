
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPytorchCoremlCyclegan {
  static const MethodChannel _channel = MethodChannel('flutter_pytorch_coreml_cyclegan');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
