import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'photo_manager_method_channel.dart';

abstract class PhotoManagerPlatform extends PlatformInterface {
  /// Constructs a PhotoManagerPlatform.
  PhotoManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static PhotoManagerPlatform _instance = MethodChannelPhotoManager();

  /// The default instance of [PhotoManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelPhotoManager].
  static PhotoManagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PhotoManagerPlatform] when
  /// they register themselves.
  static set instance(PhotoManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
