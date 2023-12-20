import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_photo_manager_platform_interface.dart';

/// An implementation of [FlutterPhotoManagerPlatform] that uses method channels.
class MethodChannelFlutterPhotoManager extends FlutterPhotoManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_photo_manager');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
