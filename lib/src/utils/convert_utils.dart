// Copyright 2018 The FlutterCandies author. All rights reserved.
// Use of this source code is governed by an Apache license that can be found
// in the LICENSE file.

import 'dart:io';
import 'package:photo_manager/src/utils/asset_entity_utils.dart';

import '../filter/base_filter.dart';
import '../filter/classical/filter_option_group.dart';
import '../filter/path_filter.dart';
import '../types/entity.dart';
import '../types/types.dart';

class ConvertUtils {
  const ConvertUtils._();

  static List<AssetPathEntity> convertToPathList(
    Map<String, dynamic> data, {
    required RequestType type,
    PMFilter? filterOption,
  }) {
    final List<AssetPathEntity> result = <AssetPathEntity>[];
    final List<Map<dynamic, dynamic>> list =
        (data['data'] as List<dynamic>).cast<Map<dynamic, dynamic>>();
    for (final Map<dynamic, dynamic> item in list) {
      // Skip paths with empty assets.
      if (item['assetCount'] == 0) {
        continue;
      }
      result.add(
        convertMapToPath(
          item.cast<String, dynamic>(),
          type: type,
          filterOption: filterOption ?? FilterOptionGroup(),
        ),
      );
    }
    return result;
  }
  // not for Windows
  static List<AssetEntity> convertToAssetList(Map<String, dynamic> data) {
    final List<AssetEntity> result = <AssetEntity>[];
    final List<Map<dynamic, dynamic>> list =
        (data['data'] as List<dynamic>).cast<Map<dynamic, dynamic>>();
    for (final Map<dynamic, dynamic> item in list) {
      // if (Platform.isWindows) {
      //   final AssetEntity rawEntity = AssetEntity(
      //     id: item['id'] as String,
      //     typeInt: item['type'] as int,
      //     width: item['width'] as int,
      //     height: item['height'] as int,
      //     duration: item['duration'] as int? ?? 0,
      //     orientation: item['orientation'] as int? ?? 0,
      //     isFavorite: item['favorite'] as bool? ?? false,
      //     title: item['title'] as String? ?? "",
      //     subtype: item['subtype'] as int? ?? 0,
      //     createDateSecond: item['createDt'] as int?,
      //     modifiedDateSecond: item['modifiedDt'] as int?,
      //     relativePath: item['relativePath'] as String?,
      //     latitude: item['lat'] as double?,
      //     longitude: item['lng'] as double?,
      //     mimeType: item['mimeType'] as String?,
      //   );
      //
      //   final AssetEntity entity = AssetEntity(
      //     id: AssetEntityUtils.generateUniqueId(rawEntity),
      //     typeInt: AssetEntityUtils.getTypeInt(rawEntity),
      //     width: rawEntity.width,
      //     height: rawEntity.height,
      //     duration: AssetEntityUtils.getDuration(rawEntity),
      //     orientation: rawEntity.orientation,
      //     isFavorite: rawEntity.isFavorite,
      //     title: rawEntity.title,
      //     subtype: rawEntity.subtype,
      //     createDateSecond: rawEntity.createDateSecond,
      //     modifiedDateSecond: rawEntity.modifiedDateSecond,
      //     relativePath: rawEntity.relativePath,
      //     latitude: rawEntity.latitude,
      //     longitude: rawEntity.longitude,
      //     mimeType: rawEntity.mimeType,
      //   );
      //   result.add(entity);
      // } else
      //{
        result.add(convertMapToAsset(item.cast<String, dynamic>()));
      //}
    }
    return result;
  }

  static AssetPathEntity convertMapToPath(
    Map<String, dynamic> data, {
    required RequestType type,
    PMFilter? filterOption,
  }) {
    final int? modified = data['modified'] as int?;
    final DateTime? lastModified = modified != null
        ? DateTime.fromMillisecondsSinceEpoch(modified * 1000)
        : null;
    final AssetPathEntity result = AssetPathEntity(
      id: data['id'] as String,
      name: data['name'] as String,
      // ignore: deprecated_member_use_from_same_package
      assetCount: data['assetCount'] as int? ?? 0,
      albumType: data['albumType'] as int? ?? 1,
      filterOption: filterOption ?? FilterOptionGroup(),
      lastModified: lastModified,
      type: type,
      isAll: data['isAll'] as bool,
      darwinType: PMDarwinAssetCollectionTypeExt.fromValue(
        data['darwinAssetCollectionType'],
      ),
      darwinSubtype: PMDarwinAssetCollectionSubtypeExt.fromValue(
        data['darwinAssetCollectionSubtype'],
      ),
    );
    return result;
  }

  static AssetEntity convertMapToAsset(
    Map<String, dynamic> data, {
    String? title,
  }) {
    final AssetEntity result = AssetEntity(
      id: data['id'] as String,
      typeInt: data['type'] as int,
      width: data['width'] as int,
      height: data['height'] as int,
      duration: data['duration'] as int? ?? 0,
      orientation: data['orientation'] as int? ?? 0,
      isFavorite: data['favorite'] as bool? ?? false,
      title: data['title'] as String? ?? title,
      subtype: data['subtype'] as int? ?? 0,
      createDateSecond: data['createDt'] as int?,
      modifiedDateSecond: data['modifiedDt'] as int?,
      relativePath: data['relativePath'] as String?,
      latitude: data['lat'] as double?,
      longitude: data['lng'] as double?,
      mimeType: data['mimeType'] as String?,
    );
    return result;
  }
}
