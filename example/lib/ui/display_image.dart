import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pytorch_coreml_cyclegan/flutter_pytorch_coreml_cyclegan.dart';
import 'package:flutter_pytorch_coreml_cyclegan_example/utils/file_utils.dart';

class DisplayImage extends StatefulWidget {
  final String modelPath;

  const DisplayImage({
    required this.modelPath,
    Key? key 
  }) : super(key: key);

  @override
  _DisplayImageState createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {

  Image? _imageShown;
  String? _imagePath;
  bool _isConverted = false;

  @override
  void initState() {
    super.initState();
    loadAssetImg();
  }

  Future<void> loadAssetImg() async {
    const assetImg = Image(image: AssetImage(_Const.assetPath));
    final imagePath = await FileUtils.copyAssetToCache(_Const.assetPath, _Const.imageName);

    setState(() {
      _imageShown = assetImg;
      _imagePath = imagePath;
      _isConverted = false;
    });
  }

  Future<void> convert() async {
    final imagePath = _imagePath;
    if (imagePath == null) return;

    final outputPath = await FileUtils.joinPathToCache(_Const.outputName);
    
    final result = await GANImageConverter
        .transformImage(imagePath, widget.modelPath, outputPath);
    print(result);
    if (result) {
      final newImage = Image.file(File(outputPath));
      
      if (!mounted) return;

      setState(() {
        _imageShown = newImage;
        _imagePath = outputPath;
        _isConverted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // type promotion only works for local vars
    final imageShown = _imageShown;

    return imageShown != null
        ? Column(
          children: [
            imageShown,
            !_isConverted 
                ? ElevatedButton(
                  onPressed: convert, 
                  child: const Text('convert')
                )
                : ElevatedButton(
                  onPressed: loadAssetImg, 
                  child: const Text('reset')
                ),
            Text('image path: ${_imagePath ?? 'error path'}'),
            const SizedBox(height: 24),
            Text('model path: ${widget.modelPath}')
          ],
        )
        : const Text('No Images');
  }
}

class _Const {
  static const assetPath = 'assets/target.jpg';

  static const imageName = 'target.jpg';
  static const outputName = 'output.jpg';
}
