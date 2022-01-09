import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

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
  String? _modelPath;

  @override
  void initState() {
    super.initState();
    loadMLModel();
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
            child: modelPath != null
                ? DisplayImage(modelPath: modelPath)
                : const Text('model loading...')
          ),
        ),
      ),
    );
  }
}

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
    'GANModel.ptl'
  );

  const _Config._ios(): this._(
    'assets/coreml_model/GANModelFloat16.mlmodel',
    'GANModel.mlmodel'
  );
}
