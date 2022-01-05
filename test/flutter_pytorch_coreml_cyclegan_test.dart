import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pytorch_coreml_cyclegan/flutter_pytorch_coreml_cyclegan.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_pytorch_coreml_cyclegan');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterPytorchCoremlCyclegan.platformVersion, '42');
  });
}
