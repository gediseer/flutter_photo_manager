#ifndef FLUTTER_PLUGIN_PHOTO_MANAGER_PLUGIN_H_
#define FLUTTER_PLUGIN_PHOTO_MANAGER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>
#include <flutter/encodable_value.h>

namespace photo_manager {

class PhotoManagerPlugin : public flutter::Plugin {
 public:
    const int MEDIA_TYPE_IMAGE = 1;
    const int MEDIA_TYPE_AUDIO = 2;
    const int MEDIA_TYPE_VIDEO = 3;
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  PhotoManagerPlugin();

  virtual ~PhotoManagerPlugin();

  // Disallow copy and assign.
  PhotoManagerPlugin(const PhotoManagerPlugin&) = delete;
  PhotoManagerPlugin& operator=(const PhotoManagerPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
  void GetAssetsByRange(std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace photo_manager

#endif  // FLUTTER_PLUGIN_PHOTO_MANAGER_PLUGIN_H_
