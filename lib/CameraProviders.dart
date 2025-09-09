import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class CameraControllerNotifier
    extends AutoDisposeAsyncNotifier<CameraController> {
  @override
  Future<CameraController> build() async {
    // Providerが実行されるタイミングでカメラリストを取得
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      throw Exception('利用可能なカメラがありません');
    }
    // 内カメラを優先的に使用し、なければ最初のカメラを使用
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      // もし内カメラがなかった場合のフォールバックとして最初のカメラを使用
      orElse: () => cameras.first,
    );
    // CameraControllerの初期化
    final controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    ref.onDispose(() {
      controller.dispose();
    });

    await controller.initialize();

    return controller;
  }
}

final cameraControllerProvider =
    AsyncNotifierProvider.autoDispose<
      CameraControllerNotifier,
      CameraController
    >(CameraControllerNotifier.new);

final countdownProvider = StateNotifierProvider<CountdownNotifier, int>((ref) {
  return CountdownNotifier();
});

class CountdownNotifier extends StateNotifier<int> {
  // 初期値は0（タイマー非作動中）
  CountdownNotifier() : super(0);

  Timer? _timer;

  // タイマーを開始するメソッド
  void startTimer() {
    // すでにタイマーが作動中なら何もしない
    if (_timer?.isActive ?? false) return;

    // 10秒にセットしてカウントダウン開始
    state = 10;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 1) {
        state--;
      } else {
        // 0になったらタイマーを止める
        state = 0;
        _timer?.cancel();
      }
    });
  }

  // タイマーをリセットするメソッド
  void resetTimer() {
    _timer?.cancel();
    state = 0;
  }

  @override
  void dispose() {
    // Providerが破棄されるときにタイマーもキャンセルする
    _timer?.cancel();
    super.dispose();
  }
}
