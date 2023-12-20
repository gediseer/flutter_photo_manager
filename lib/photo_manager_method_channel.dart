import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'photo_manager_platform_interface.dart';

/// An implementation of [PhotoManagerPlatform] that uses method channels.
class MethodChannelPhotoManager extends PhotoManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('photo_manager');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
