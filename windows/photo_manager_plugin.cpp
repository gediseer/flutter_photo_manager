#include "photo_manager_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>
#include <filesystem>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>
#include "logger.h"
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>
#include <opencv2/opencv.hpp>
#include <memory>
#include <sstream>

namespace photo_manager {

	// static
	void PhotoManagerPlugin::RegisterWithRegistrar(
		flutter::PluginRegistrarWindows* registrar) {
		auto channel =
			std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
				registrar->messenger(), "com.fluttercandies/photo_manager",
				&flutter::StandardMethodCodec::GetInstance());

		auto plugin = std::make_unique<PhotoManagerPlugin>();

		channel->SetMethodCallHandler(
			[plugin_pointer = plugin.get()](const auto& call, auto result) {
				plugin_pointer->HandleMethodCall(call, std::move(result));
			});

		registrar->AddPlugin(std::move(plugin));
	}

	PhotoManagerPlugin::PhotoManagerPlugin() {}

	PhotoManagerPlugin::~PhotoManagerPlugin() {}
	// use this static const as data dir on windows
	//todo user can set default cache dir
	static const std::vector<std::string> assetPaths = { "C:\\Users\\win\\Desktop\\newFolder\\localPics" };

	void PhotoManagerPlugin::HandleMethodCall(
		const flutter::MethodCall<flutter::EncodableValue>& method_call,
		std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
		if (method_call.method_name().compare("getPlatformVersion") == 0) {
			std::ostringstream version_stream;
			version_stream << "hello from Windows ";
			if (IsWindows10OrGreater()) {
				version_stream << "10+";
			}
			else if (IsWindows8OrGreater()) {
				version_stream << "8";
			}
			else if (IsWindows7OrGreater()) {
				version_stream << "7";
			}
			result->Success(flutter::EncodableValue(version_stream.str()));
		}
		else if (method_call.method_name().compare("getAssetPathList") == 0) {
			flutter::EncodableMap data;
			flutter::EncodableList list;
			flutter::EncodableMap element;
			element[flutter::EncodableValue("id")] = flutter::EncodableValue("blossom");
			element[flutter::EncodableValue("name")] = flutter::EncodableValue("blossom data folder");
			element[flutter::EncodableValue("assetCount")] = flutter::EncodableValue(29);
			element[flutter::EncodableValue("isAll")] = flutter::EncodableValue(true);
			list.push_back(element);
			data[flutter::EncodableValue("data")] = list;
			result->Success(data);
		}
		else if (method_call.method_name().compare("getAssetCount") == 0) {
			result->Success(flutter::EncodableValue(100));
		}
		else if (method_call.method_name().compare("getAssetsByRange") == 0) {

			/*flutter::EncodableList list = PhotoManagerPlugin::GetAssetsByRange();
			flutter::EncodableMap data;
			data[flutter::EncodableValue("data")] = list;*/
			std::thread t(&PhotoManagerPlugin::GetAssetsByRange,this, std::move(result));
			t.detach();
			//result->Success(data);
		}
		else {
			result->NotImplemented();
		}
	}

	 void PhotoManagerPlugin::GetAssetsByRange(std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
	{
		namespace fs = std::filesystem;

		flutter::EncodableList list;
		std::string directory_path = assetPaths.at(0);

		for (const auto& entry : fs::directory_iterator(directory_path)) {
			if (entry.is_regular_file()) {
				std::string file_path = entry.path().string();
				std::string file_extension = entry.path().extension().string();

				// Check if the file is an image or video by its extension
				if (file_extension == ".jpg" || file_extension == ".png" || file_extension == ".bmp" || file_extension == ".jpeg" ||
					file_extension == ".mp4" || file_extension == ".avi") {

					flutter::EncodableMap element;

					// Gather image metadata
					struct stat fileStat;
					if (stat(file_path.c_str(), &fileStat) == -1) {
						//logger::log("file data read failed, skip");
						continue;
					}

					// 2.
					long long fileSizeB = fileStat.st_size;

					// 3.
					char buffer[26];
					if (errno_t err = ctime_s(buffer, sizeof buffer, &fileStat.st_ctime)) {
						logger::log("get image time error", file_path);
					}
					std::string createTime = buffer;
					time_t createTime_t = fileStat.st_ctime;
					createTime = createTime.substr(0, createTime.length() - 1);

					// 4. 
					if (errno_t err = ctime_s(buffer, sizeof buffer, &fileStat.st_mtime)) {
						logger::log("get image modify time error", file_path);
					}
					std::string modifyTime = buffer;
					time_t modifyTime_t = fileStat.st_mtime;
					modifyTime = modifyTime.substr(0, modifyTime.length() - 1);

					//cv::Mat image = cv::imread(file_path);
					//// Check if the file is an image
					//if (image.empty()) {
					//	std::cout << "image file empty " << file_path << std::endl;
					//	continue;
					//}
					int width = 0;//image.cols; //image.cols;
					int height = 0;//image.rows; // image.rows;
					//6 mimetype
					std::string mimetype = "memetype"; // ImageInfo::getImageMimeType(image);
					std::cout << "image dir: " << file_path << std::endl;
					std::cout << "extension: " << file_extension << std::endl;
					std::cout << "file size(B): " << fileSizeB << " B" << std::endl;
					std::cout << "create time: " << createTime << " >> " << createTime_t << std::endl;
					std::cout << "modify time: " << modifyTime << " >> " << modifyTime_t << std::endl;
					std::cout << "img width: " << width << " pixels" << std::endl;
					std::cout << "img height: " << height << " pixels" << std::endl;
					std::cout << " file >>>>>>>>>>> " << file_path << std::endl;
					element[flutter::EncodableValue("id")] = flutter::EncodableValue("");
					element[flutter::EncodableValue("title")] = flutter::EncodableValue(file_path);
					element[flutter::EncodableValue("subtype")] = flutter::EncodableValue(0);
					element[flutter::EncodableValue("type")] = flutter::EncodableValue(1);
					element[flutter::EncodableValue("width")] = flutter::EncodableValue(width);
					element[flutter::EncodableValue("height")] = flutter::EncodableValue(height);
					element[flutter::EncodableValue("duration")] = flutter::EncodableValue(-1);
					element[flutter::EncodableValue("orientation")] = flutter::EncodableValue(1);
					//element[flutter::EncodableValue("favorite")] = flutter::EncodableValue(29);
					element[flutter::EncodableValue("createDt")] = flutter::EncodableValue(static_cast<int>(fileStat.st_ctime));
					element[flutter::EncodableValue("modifiedDt")] = flutter::EncodableValue(static_cast<int>(fileStat.st_mtime));
					element[flutter::EncodableValue("relativePath")] = flutter::EncodableValue("");
					element[flutter::EncodableValue("lat")] = flutter::EncodableValue(static_cast<double>(1));
					element[flutter::EncodableValue("lng")] = flutter::EncodableValue(static_cast<double>(1));
					element[flutter::EncodableValue("mimeType")] = flutter::EncodableValue("");
					list.push_back(element);
				}
			}
		}
		flutter::EncodableMap data;
		data[flutter::EncodableValue("data")] = list;
		result.get()->Success(data);
		//return list;
	}

}  // namespace photo_manager
