import 'dart:io';

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
    try {
      final config = _Config();
      final modelPath = 
          await FileUtils.copyAssetToAppDir(config.assetModelPath, config.appDirModelPath);
      setState(() {
        _modelPath = modelPath;
      });
    } on Exception catch(e) {
      print(e);
    }
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
        body: SingleChildScrollView(
          child: Center(
            // child: Text('Running on: $_platformVersion\n'),
            child: modelPath != null
                ? DisplayImage(modelPath: modelPath)
                : const Text('model loading...')
          ),
        ),
      ),
    );
  }
}

// class _AndroidConfig extends _Config {
//   @override
//   final assetModelPath = 'assets/pytorch_model/GANModelFloat32.ptl';
//   @override
//   final appDirModelPath = 'GANModelFloat32.ptl';
// }

// class _IOSConfig extends _Config {
//   @override
//   final assetModelPath = 'assets/pytorch_model/GANModelFloat32.ptl';
//   @override
//   final appDirModelPath = 'GANModelFloat32.ptl';

//   const _IOSConfig();
// }

class _Config {
  final String assetModelPath;
  final String appDirModelPath;

  // private constructor
  const _Config._(
    this.assetModelPath,
    this.appDirModelPath
  );

  factory _Config() {
    final _Config instance;
    if (Platform.isAndroid) {
      instance = const _Config._android();
    } else if (Platform.isIOS) {
      instance = const _Config._ios();
    } else {
      throw Exception("the platform not supported; supporting ios or android");
    }
    return instance;
  }

  const _Config._android(): this._(
    'assets/pytorch_model/GANModelFloat32.ptl',
    'GANModelFloat32.ptl'
  );

  const _Config._ios(): this._(
    'assets/coreml_model/GANModelInt8.mlmodel',
    'GANModelInt8.mlmodel'
  );
}
