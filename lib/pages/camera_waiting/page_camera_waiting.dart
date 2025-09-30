import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_app_nana_project/providers/user_image_provider.dart';

class PageCameraWaiting extends ConsumerStatefulWidget {
  const PageCameraWaiting({super.key});

  @override
  ConsumerState<PageCameraWaiting> createState() => _PageCameraWaitingState();
}

class _PageCameraWaitingState extends ConsumerState<PageCameraWaiting> {
  late StreamSubscription<DocumentSnapshot> _subscription;
  bool _isNavigating = false;
  // UIの状態を管理するための新しいState変数を追加
  bool _isLoadingImage = false;

  @override
  void initState() {
    super.initState();
    final triggerDocRef = FirebaseFirestore.instance
        .collection('camera')
        .doc('trigger');

    _subscription = triggerDocRef.snapshots().listen((snapshot) async {
      if (snapshot.exists && !_isNavigating && mounted) {
        final data = snapshot.data() as Map<String, dynamic>;
        if (data['takePhoto'] == false && data['latestImageName'] != null) {
          // 画像読み込みが開始されることをUIに通知
          setState(() {
            _isNavigating = true;
            _isLoadingImage = true; // テキストを「読み込み中」に変更
          });

          final imageName = data['latestImageName'] as String;

          try {
            // Invalidate to ensure fresh data if this screen is revisited.
            ref.invalidate(imageBytesProvider(imageName));
            // Pre-fetch the image. The provider will cache the result.
            await ref.read(imageBytesProvider(imageName).future);

            if (mounted) {
              context.pushReplacement('/camera_preview', extra: imageName);
            }
          } catch (e) {
            if (mounted) {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text('Error'),
                  content: Text('Failed to load image: $e'),
                  actions: [
                    CupertinoDialogAction(
                      child: Text('OK'),
                      onPressed: () {
                        context.pop();
                        // Go back to the previous screen on error.
                        if (context.canPop()) {
                          context.pop();
                        }
                      },
                    ),
                  ],
                ),
              );
              // エラー発生時はStateをリセット
              setState(() {
                _isNavigating = false;
                _isLoadingImage = false; // テキストを元に戻す
              });
            }
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CupertinoActivityIndicator(radius: 40),
            const SizedBox(height: 40),
            // _isLoadingImage の状態に応じて表示するテキストを変更
            Text(
              _isLoadingImage ? '画像を読み込み中...' : '撮影中だよ！カメラを見てね！',
              style: const TextStyle(
                fontSize: 24,
                color: CupertinoColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
