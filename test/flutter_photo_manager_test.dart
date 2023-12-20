import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_photo_manager/flutter_photo_manager.dart';
import 'package:flutter_photo_manager/flutter_photo_manager_platform_interface.dart';
import 'package:flutter_photo_manager/flutter_photo_manager_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPhotoManagerPlatform
    with MockPlatformInterfaceMixin
    implements FlutterPhotoManagerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterPhotoManagerPlatform initialPlatform = FlutterPhotoManagerPlatform.instance;

  test('$MethodChannelFlutterPhotoManager is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPhotoManager>());
  });

  test('getPlatformVersion', () async {
    FlutterPhotoManager flutterPhotoManagerPlugin = FlutterPhotoManager();
    MockFlutterPhotoManagerPlatform fakePlatform = MockFlutterPhotoManagerPlatform();
    FlutterPhotoManagerPlatform.instance = fakePlatform;

    expect(await flutterPhotoManagerPlugin.getPlatformVersion(), '42');
  });
}
