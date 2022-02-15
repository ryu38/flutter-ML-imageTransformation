import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ml_image_transformation/flutter_ml_image_transformation.dart';
import 'package:flutter_ml_image_transformation_example/utils/file_utils.dart';

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
  bool _isStarted = false;
  double _time = 0;

  Timer? _timer;

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
      _isStarted = false;
      _time = 0;
    });
  }

  Future<void> convert() async {
    final imagePath = _imagePath;
    if (imagePath == null) return;

    if (!mounted) return;
    setState(() {
      _isStarted = true;
    });

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _time = _time + 0.1;
      });
    });

    final outputPath = await FileUtils.joinPathToCache(_Const.outputName);
    
    final result = await MLImageTransformer.transformImage(
      imagePath: imagePath, outputPath: outputPath,
    );
    _timer?.cancel();
    print(result ?? "no error");
    if (result == null) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !_isConverted 
                    ? ElevatedButton(
                      onPressed: !_isStarted ? convert : null, 
                      child: const Text('convert')
                    )
                    : ElevatedButton(
                      onPressed: loadAssetImg, 
                      child: const Text('reset')
                    ),
                const SizedBox(width: 16),
                Text('sec: ${_time.toStringAsFixed(1)}'),
              ],
            ),
            Text('image path: ${_imagePath ?? 'error path'}'),
            const SizedBox(height: 24),
            Text('model path: ${widget.modelPath}')
          ],
        )
        : const Text('No Images');
  }
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({ Key? key }) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {

  double _time = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _time = _time + 0.1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

class _Const {
  static const assetPath = 'assets/target.jpg';

  static const imageName = 'target.jpg';
  static const outputName = 'output.jpg';
}
