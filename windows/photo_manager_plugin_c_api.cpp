#include "include/photo_manager/photo_manager_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "photo_manager_plugin.h"

void PhotoManagerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  photo_manager::PhotoManagerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
