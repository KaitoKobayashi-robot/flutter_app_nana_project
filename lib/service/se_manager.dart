import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// SE (効果音) 専用のマネージャー
/// SEは同時再生や即時性が求められるため、BGMとは分離する
class SeManager {
  /// ボタンクリック音を再生する
  Future<void> playTapSound() async {
    // 新しいプレイヤーインスタンスを作って、すぐに再生する
    await AudioPlayer().play(AssetSource('audio/button_se.ogg'));
  }

  // // 他のSE (例: シャッター音)
  // Future<void> playShutterSound() async {
  //   await AudioPlayer().play(AssetSource('sounds/shutter.mp3'));
  // }
}

final seManagerProvider = Provider<SeManager>((ref) {
  return SeManager();
});
