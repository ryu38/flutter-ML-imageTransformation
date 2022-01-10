import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ml_image_transformation/flutter_ml_image_transformation.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_ml_image_transformation');

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
    expect(await MLImageTransformer.platformVersion, '42');
  });
}
