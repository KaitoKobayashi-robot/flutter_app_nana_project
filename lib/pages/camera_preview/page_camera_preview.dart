import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/camera_preview/widgets/buttons.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '/providers/user_image_provider.dart';

// 画面遷移時にファイル名を受け取るためStatefulWidgetに変更
class PageCameraPreview extends ConsumerStatefulWidget {
  final Object? extra;
  const PageCameraPreview({this.extra, super.key});

  @override
  ConsumerState<PageCameraPreview> createState() => _PageCameraPreviewState();
}

class _PageCameraPreviewState extends ConsumerState<PageCameraPreview> {
  String? imageName;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // GoRouterのextraからファイル名を取得
    if (widget.extra is String) {
      imageName = widget.extra as String;
    }
  }

  Future<void> push(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    if (context.mounted) {
      await context.push('/write');
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // 「もう一度撮る」ボタンの処理
  Future<void> back(BuildContext context) async {
    // 現在の画像のファイル名を指定して削除
    await ref.read(imageServiceProvider).deleteImage(imageName);

    if (context.mounted) {
      context.pop();
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // ファイル名がない場合はエラーメッセージを表示
    if (imageName == null || imageName!.isEmpty) {
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

    // ファイル名を指定して画像データを監視
    final asyncImageData = ref.watch(imageByNameProvider(imageName!));

    return CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: Center(
        child: _isLoading
            ? const CupertinoActivityIndicator(radius: 20)
            : asyncImageData.when(
                loading: () => const CupertinoActivityIndicator(radius: 20),
                error: (error, stackTrace) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('画像の読み込みに失敗しました: $error'),
                    const SizedBox(height: 20),
                    ReTakeButton(onPressed: () => back(context)),
                  ],
                ),
                data: (imageData) {
                  if (imageData == null) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('画像が見つかりません'),
                        const SizedBox(height: 20),
                        ReTakeButton(onPressed: () => back(context)),
                      ],
                    );
                  }
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
