import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';

// UIで表示するための画像データを保持するプロバイダー
final userImageProvider = StateProvider<Uint8List?>((ref) => null);

// 【変更】ファイル名に基づいて画像のダウンロードURLを取得するプロバイダーファミリー
final imageUrlByNameProvider = FutureProvider.family<String?, String>((
  ref,
  imageName,
) async {
  if (imageName.isEmpty) {
    return null;
  }
  try {
    final imageRef = FirebaseStorage.instance.ref('user_images_raw/$imageName');
    final downloadUrl = await imageRef.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    debugPrint('Failed to get image URL by name "$imageName": $e');
    return null;
  }
});

// 【新設】画像名から画像のバイトデータを取得するProvider
// このProviderがURLの取得と画像のダウンロードをまとめて行います。
final imageBytesProvider = FutureProvider.family<Uint8List?, String>((
  ref,
  imageName,
) async {
  // まず画像URLを取得
  final imageUrl = await ref.watch(imageUrlByNameProvider(imageName).future);

  if (imageUrl == null || imageUrl.isEmpty) {
    return null; // URLがなければnullを返す
  }

  // NetworkImageを使って画像データをバイトに変換
  final completer = Completer<Uint8List?>();
  final imageProvider = NetworkImage(imageUrl);
  final listener = ImageStreamListener(
    (ImageInfo info, bool _) {
      info.image.toByteData(format: ui.ImageByteFormat.png).then((byteData) {
        completer.complete(byteData?.buffer.asUint8List());
      });
    },
    onError: (exception, stackTrace) {
      completer.completeError(exception, stackTrace);
    },
  );

  final stream = imageProvider.resolve(const ImageConfiguration());
  stream.addListener(listener);

  // リスナーを適切に削除するために、Providerが破棄されるタイミングでクリーンアップ
  ref.onDispose(() {
    stream.removeListener(listener);
  });

  return completer.future;
});

// 画像を削除するサービスを提供するプロバイダー
final imageServiceProvider = Provider((ref) => ImageService());

class ImageService {
  /// 指定された名前の画像を削除する
  Future<void> deleteImage(String? imageName) async {
    if (imageName == null || imageName.isEmpty) {
      debugPrint('No image name provided to delete.');
      return;
    }
    try {
      final imageRef = FirebaseStorage.instance.ref(
        'user_images_raw/$imageName',
      );
      await imageRef.delete();
      debugPrint('Successfully deleted image: $imageName');
    } catch (e) {
      debugPrint('Failed to delete image "$imageName": $e');
    }
  }
}

// InteractiveViewerの現在のTransformationControllerを保持するProvider
final transformationControllerProvider = Provider.autoDispose(
  (ref) => TransformationController(),
);

// 現在のスケール値を保持するProvider
final currentScaleProvider = StateProvider<double>((ref) => 1.0);
