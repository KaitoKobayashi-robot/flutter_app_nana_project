import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/camera_preview/widgets/buttons.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '/providers/user_image_provider.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';

// 【新設】画像名から画像のバイトデータを取得するProvider
// このProviderがURLの取得と画像のダウンロードをまとめて行います。
final imageBytesProvider = FutureProvider.autoDispose
    .family<Uint8List?, String>((ref, imageName) async {
      // まず画像URLを取得
      final imageUrl = await ref.watch(
        imageUrlByNameProvider(imageName).future,
      );

      if (imageUrl == null || imageUrl.isEmpty) {
        return null; // URLがなければnullを返す
      }

      // NetworkImageを使って画像データをバイトに変換
      final completer = Completer<Uint8List?>();
      final imageProvider = NetworkImage(imageUrl);
      final listener = ImageStreamListener(
        (ImageInfo info, bool _) {
          info.image.toByteData(format: ui.ImageByteFormat.png).then((
            byteData,
          ) {
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

// 【変更】StatefulWidgetからConsumerWidgetに変更
class PageCameraPreview extends ConsumerWidget {
  final Object? extra;
  const PageCameraPreview({this.extra, super.key});

  // 「次へ」ボタンの処理
  void push(BuildContext context, WidgetRef ref, Uint8List imageBytes) {
    // Providerから受け取った画像データをuserImageProviderにセット
    ref.read(userImageProvider.notifier).state = imageBytes;
    // 画面遷移
    context.push('/write');
  }

  // 「もう一度撮る」ボタンの処理
  Future<void> back(
    BuildContext context,
    WidgetRef ref,
    String imageName,
  ) async {
    // 現在の画像のファイル名を指定して削除
    await ref.read(imageServiceProvider).deleteImage(imageName);

    if (context.mounted) {
      context.pop();
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // GoRouterのextraからファイル名を取得
    final imageName = (extra is String) ? extra as String : null;

    // ファイル名がない場合はエラーメッセージを表示
    if (imageName == null || imageName.isEmpty) {
      return CupertinoPageScaffold(
        backgroundColor: MainColors.bgColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('画像の情報が見つかりません。'),
              const SizedBox(height: 20),
              ReTakeButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      );
    }

    // 【変更】新しく作成した imageBytesProvider を監視します
    // これで画像取得までのすべての状態（ロード中、エラー、データ）を一括で管理できます
    final asyncImageBytes = ref.watch(imageBytesProvider(imageName));

    return CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: Center(
        child: asyncImageBytes.when(
          loading: () => const CupertinoActivityIndicator(radius: 20),
          error: (error, stackTrace) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('画像の読み込みに失敗しました: $error'),
              const SizedBox(height: 20),
              ReTakeButton(onPressed: () => back(context, ref, imageName)),
            ],
          ),
          data: (imageBytes) {
            // 画像データがnullまたは空の場合
            if (imageBytes == null || imageBytes.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('画像が見つかりません'),
                  const SizedBox(height: 20),
                  ReTakeButton(onPressed: () => back(context, ref, imageName)),
                ],
              );
            }

            // 成功した場合、取得したバイトデータで画像を表示
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 70),
                Expanded(
                  child: Center(
                    child: Transform.scale(
                      scale: 0.8,
                      // 【変更】Image.networkからImage.memoryへ
                      child: Image.memory(imageBytes, fit: BoxFit.contain),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReTakeButton(
                      onPressed: () => back(context, ref, imageName),
                    ),
                    // 【変更】push処理を簡略化
                    NextButton(onPressed: () => push(context, ref, imageBytes)),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            );
          },
        ),
      ),
    );
  }
}
