import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_pytorch_coreml_cyclegan/flutter_pytorch_coreml_cyclegan.dart';
import 'package:flutter_pytorch_coreml_cyclegan_example/ui/display_image.dart';
import 'package:flutter_pytorch_coreml_cyclegan_example/utils/file_utils.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatefulWidget {
  const SampleApp({Key? key}) : super(key: key);

  @override
  State<SampleApp> createState() => _SampleAppState();
}

class _SampleAppState extends State<SampleApp> {
  String _platformVersion = 'Unknown';
  String? _modelPath;

  @override
  void initState() {
    super.initState();
    loadMLModel();
    // initPlatformState();
  }

  Future<void> loadMLModel() async {
    final modelPath = 
        await FileUtils.copyAssetToAppDir(_Const.assetModelPath, _Const.appDirModelPath);
    setState(() {
      _modelPath = modelPath;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await GANImageConverter.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    final modelPath = _modelPath;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          // child: Text('Running on: $_platformVersion\n'),
          child: modelPath != null
              ? DisplayImage(modelPath: modelPath)
              : const Text('model loading...')
        ),
      ),
    );
  }
}

class _Const {
  static const assetModelPath = 'assets/pytorch_model/GANModelFloat32.ptl';
  static const appDirModelPath = 'GANModelFloat32.ptl';
}
