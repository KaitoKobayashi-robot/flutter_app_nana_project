import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/camera_preview/widgets/buttons.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '/providers/user_image_provider.dart';

class PageCameraPreview extends ConsumerWidget {
  const PageCameraPreview({super.key});

  push(BuildContext context) {
    context.push('/write');
  }

  back(BuildContext context) async {
    if (context.mounted) {
      context.pop();
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImageData = ref.watch(latestImageProvider);

    return CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: Center(
        // FutureProvider の状態 (AsyncValue) に応じて表示するウィジェットを切り替える
        child: asyncImageData.when(
          loading: () => const CupertinoActivityIndicator(radius: 20),
          error: (error, stackTrace) => Text('画像の読み込みに失敗しました: $error'),
          data: (imageData) {
            if (imageData == null) {
              return const Text('画像が見つかりません');
            }
            // 画像データを正常に取得できた場合
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.read(userImageProvider.notifier).state = imageData;
            });
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 70),
                Expanded(
                  child: Center(
                    child: Transform.scale(
                      scale: 0.8,
                      child: Image.memory(imageData, fit: BoxFit.contain),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReTakeButton(onPressed: () => back(context)),
                    NextButton(onPressed: () => push(context)),
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
