import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_ml_image_transformation_example/main.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final controller = CameraController(
      camera,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
      enableAudio: false,
    );
    await controller.initialize();
    setState(() {
      _controller = controller;
    });
  }

  Future<void> _takePhoto(CameraController controller) async {
    await controller.setFlashMode(FlashMode.off);
    final imageXFile = await controller.takePicture();
    final rotatedFile =
        await FlutterExifRotation.rotateImage(path: imageXFile.path);
    Navigator.of(context).pop(rotatedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CameraPreview(_controller!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _takePhoto(_controller!),
                  child: const Text('take photo'),
                ),
              ],
            ),
    );
  }
}
