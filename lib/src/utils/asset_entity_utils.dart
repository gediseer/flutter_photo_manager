// Copyright 2018 The FlutterCandies author. All rights reserved.
// Use of this source code is governed by an Apache license that can be found
// in the LICENSE file.

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:path/path.dart' as path;

class AssetEntityUtils {
  static const int MEDIA_TYPE_IMAGE = 1;
  static const int MEDIA_TYPE_AUDIO = 2;
  static const int MEDIA_TYPE_VIDEO = 3;
  static const int MEDIA_TYPE_UNKNOWN = -1;

  static generateUniqueId(AssetEntity entity) {
    var bytes = utf8.encode(
        '${entity.title}_${entity.width}_${entity.height}_${entity.createDateTime.millisecondsSinceEpoch}'); // data being hashed
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  static getTypeInt(AssetEntity rawEntity) {
    getTypeIntFromTitle(rawEntity.title!);
  }

  static getTypeIntFromTitle(String title) {
    var extension = path.extension(title).toLowerCase();

    var imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
    var videoExtensions = ['.mp4', '.avi', '.mov', '.flv', '.wmv'];
    var audioExtensions = ['.mp3', '.wav', '.wma', '.m4a', '.aac'];

    if (imageExtensions.contains(extension)) {
      return MEDIA_TYPE_IMAGE;
    } else if (videoExtensions.contains(extension)) {
      return MEDIA_TYPE_VIDEO;
    } else if (audioExtensions.contains(extension)) {
      return MEDIA_TYPE_AUDIO;
    } else {
      return MEDIA_TYPE_UNKNOWN;
    }
  }

  static getDuration(AssetEntity rawEntity) {
    if (rawEntity.type == AssetType.audio) {
      return rawEntity.duration;
    } else if (rawEntity.type == AssetType.video) {
      return rawEntity.duration;
    } else {
      return 0;
    }
  }
}
