import 'package:flutter/cupertino.dart';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';

final userImageProvider = StateProvider<Uint8List?>((ref) => null);

// InteractiveViewerの現在のTransformationControllerを保持するProvider
final transformationControllerProvider = Provider.autoDispose(
  (ref) => TransformationController(),
);

// 現在のスケール値を保持するProvider
final currentScaleProvider = StateProvider<double>((ref) => 1.0);

// === 修正・改善されたProvider ===
final latestImageProvider = FutureProvider<Uint8List?>((ref) async {
  try {
    final storageRef = FirebaseStorage.instance.ref('user_images_raw');
    final listResult = await storageRef.listAll();

    // ディレクトリ内にアイテムがなければnullを返す
    if (listResult.items.isEmpty) {
      debugPrint('No items found in user_images_raw.');
      return null;
    }

    // 1. 全アイテムのメタデータを並列で取得 (パフォーマンス向上)
    final metadataList = await Future.wait(
      listResult.items.map((item) => item.getMetadata()).toList(),
    );

    // 2. メタデータと元のReferenceをペアにする
    final List<Map<String, dynamic>> itemsWithMetadata = [];
    for (int i = 0; i < listResult.items.length; i++) {
      itemsWithMetadata.add({
        'ref': listResult.items[i],
        'metadata': metadataList[i],
      });
    }

    // 3. 更新日時で降順にソートして、最新のアイテムを特定
    itemsWithMetadata.sort((a, b) {
      final aTime = a['metadata'].updated;
      final bTime = b['metadata'].updated;
      if (aTime == null && bTime == null) return 0;
      if (aTime == null) return 1; // nullを後ろに
      if (bTime == null) return -1; // nullを後ろに
      return bTime.compareTo(aTime); // 新しいものが先頭に来るように
    });

    // ソート後の先頭が最新のアイテム
    final latestItemRef = itemsWithMetadata.first['ref'] as Reference?;

    // 4. 最新のアイテムのデータを取得して返す
    if (latestItemRef != null) {
      final imageData = await latestItemRef.getData();
      return imageData;
    }

    return null;
  } catch (e) {
    // エラーハンドリングを強化
    debugPrint('Failed to get latest image from Firebase Storage: $e');
    if (e is FirebaseException && e.code == 'object-not-found') {
      debugPrint('Directory or file does not exist.');
    } else if (e is FirebaseException && e.code == 'unauthorized') {
      debugPrint(
        'Permission denied. Check your Firebase Storage security rules.',
      );
    }
    return null;
  }
});
