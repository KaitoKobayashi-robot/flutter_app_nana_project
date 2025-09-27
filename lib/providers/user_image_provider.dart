import 'package:flutter/cupertino.dart';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';

// UIで表示するための画像データを保持するプロバイダー
final userImageProvider = StateProvider<Uint8List?>((ref) => null);

// ファイル名に基づいて画像データを取得するプロバイダーファミリー
final imageByNameProvider = FutureProvider.family<Uint8List?, String>((
  ref,
  imageName,
) async {
  if (imageName.isEmpty) {
    return null;
  }
  try {
    final imageRef = FirebaseStorage.instance.ref('user_images_raw/$imageName');
    final imageData = await imageRef.getData();
    // 取得したデータをUI用のプロバイダーにもセットする
    ref.read(userImageProvider.notifier).state = imageData;
    return imageData;
  } catch (e) {
    debugPrint('Failed to get image by name "$imageName": $e');
    return null;
  }
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
