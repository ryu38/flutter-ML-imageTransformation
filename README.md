# Flutter ML Image Transformation
The flutter plugin for image-to-image-transformation using PyTorch-mobile (android) and CoreML (ios)

## Installation
Add lines like below under `dependencies` in your package's pubspec.yaml and run `flutter pub get`.
```yaml
dependencies:

  # ...

  flutter_ml_image_transformation:
      git:
        url: https://github.com/ryu38/flutter-ML-imageTransformation.git
        ref: master
```

## Usage
1. Create a assets folder to import models of PyTorch and/or CoreML. Add lines like below in pubspec.yaml.
```yaml
assets:
    - assets/pytorch_model/
    - assets/coreml_model/
```
2. Store models in the assets folder created.
3. Copy your model to a documents directory.  
[About Documents Directory](https://docs.flutter.dev/cookbook/persistence/reading-writing-files)
```dart
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


// Use a different model for IOS or android.
final String assetModelPath;
final String appDirModelName;
if (Platform.isAndroid) {
  assetModelPath = 'assets/pytorch_model/MyModel.ptl';
  appDirModelName = 'MyModel.ptl';
} else if (Platform.isIOS) {
  assetModelPath = 'assets/coreml_model/MyModel.mlmodel';
  appDirModelName = 'MyModel.mlmodel';
} else {
  throw Exception();
}

// Get a path to a documents directory and define a path to a model to be copied there.
final appDir = await getApplicationDocumentsDirectory();
final appDirModelPath = join(appDir.path, appDirModelName);

// Copy your model in the assets folder there.
final byteData = await rootBundle.load(assetModelPath);
final bytes = byteData.buffer
    .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
await File(appDirModelPath).writeAsBytes(bytes);
```
4. Import the library.
```dart
import 'package:flutter_ml_image_transformation/flutter_ml_image_transformation.dart';
```
5. Load your model by `MLImageTransformer.setModel()` before executing Image Transformation.  
`inputWidth` and `inputHeight` are set to `256` by default.
```dart
final result = await MLImageTransformer.setModel(
  modelPath: modelPath, inputWidth: 256, inputHeight: 256,
);
if (result != null) throw Exception(result);
```
6. Execute Image Transformation by `MLImageTransformer.transformImage()`.  
`imagePath` and `outputPath` need to be readable by the app (Documents Directory or Temporary Directory).
```dart
final result = await MLImageTransformer.transformImage(
  imagePath: imagePath, outputPath: outputPath
);
if (result != null) throw Exception(result);
```
---
#### NOTE
You can also learn more about how to use the package from [/example](example/).
