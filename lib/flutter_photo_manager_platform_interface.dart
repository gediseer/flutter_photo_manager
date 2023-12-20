import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_photo_manager_method_channel.dart';

abstract class FlutterPhotoManagerPlatform extends PlatformInterface {
  /// Constructs a FlutterPhotoManagerPlatform.
  FlutterPhotoManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPhotoManagerPlatform _instance = MethodChannelFlutterPhotoManager();

  /// The default instance of [FlutterPhotoManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPhotoManager].
  static FlutterPhotoManagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPhotoManagerPlatform] when
  /// they register themselves.
  static set instance(FlutterPhotoManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
