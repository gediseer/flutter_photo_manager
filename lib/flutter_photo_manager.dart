
import 'flutter_photo_manager_platform_interface.dart';

class FlutterPhotoManager {
  Future<String?> getPlatformVersion() {
    return FlutterPhotoManagerPlatform.instance.getPlatformVersion();
  }
}
