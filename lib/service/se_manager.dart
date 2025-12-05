import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// SE (効果音) 専用のマネージャー
/// SEは同時再生や即時性が求められるため、BGMとは分離する
class SeManager {
  AudioPlayer? _drumRollPlayer;

  /// ボタンクリック音を再生する
  Future<void> playTapSound() async {
    // 新しいプレイヤーインスタンスを作って、すぐに再生する
    await AudioPlayer().play(AssetSource('audio/button_se.ogg'));
  }

  Future<void> playHomete() async {
    await AudioPlayer().play(
      AssetSource("audio/homete_fixed.ogg"),
      volume: 0.8,
    );
  }

  Future<void> playGoriyou() async {
    await AudioPlayer().play(
      AssetSource("audio/goriyou_fixed.ogg"),
      volume: 0.8,
    );
  }

  Future<void> playHomeodai() async {
    await AudioPlayer().play(
      AssetSource("audio/homeodai_half_fixed.ogg"),
      volume: 0.8,
    );
  }

  Future<void> playDrumRoll() async {
    await _drumRollPlayer?.stop();
    _drumRollPlayer = AudioPlayer();
    await _drumRollPlayer!.play(AssetSource("audio/drum_roll.ogg"), volume: 1);
  }

  Future<void> stopDrumRoll() async {
    if (_drumRollPlayer != null) {
      await _drumRollPlayer!.stop();
      await _drumRollPlayer!.dispose();
      _drumRollPlayer = null;
    }
  }

  Future<void> playDenn() async {
    await AudioPlayer().play(AssetSource("audio/roll_close.ogg"), volume: 1);
  }

  Future<void> playDarewoDonoyouni() async {
    await AudioPlayer().play(
      AssetSource("audio/darewo_donoyouni_fixed.ogg"),
      volume: 0.8,
    );
  }

  Future<void> playTakePhoto() async {
    await AudioPlayer().play(AssetSource("audio/start_fixed.ogg"), volume: 0.8);
  }

  Future<void> playWrite() async {
    await AudioPlayer().play(AssetSource("audio/write_fixed.ogg"), volume: 0.8);
  }

  Future<void> playQR() async {
    await AudioPlayer().play(AssetSource("audio/QR_fixed.ogg"), volume: 0.8);
  }

  // // 他のSE (例: シャッター音)
  // Future<void> playShutterSound() async {
  //   await AudioPlayer().play(AssetSource('sounds/shutter.mp3'));
  // }
}

final seManagerProvider = Provider<SeManager>((ref) {
  return SeManager();
});
