import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';

/// BGM再生ロジックとアプリのライフサイクルを管理するサービス
class BgmService {
  final AudioPlayer _bgmPlayer = AudioPlayer();

  BgmService() {
    _initBgm();
  }

  Future<void> _initBgm() async {
    await AudioPlayer.global.setAudioContext(
      AudioContext(
        iOS: AudioContextIOS(category: AVAudioSessionCategory.ambient),
        android: AudioContextAndroid(
          isSpeakerphoneOn: true,
          stayAwake: true,
          contentType: AndroidContentType.music,
          usageType: AndroidUsageType.game,
          audioFocus: AndroidAudioFocus.none,
        ),
      ),
    );

    // 1. ループ設定
    await _bgmPlayer.setReleaseMode(ReleaseMode.loop);

    // 2. 音量設定 (初期値0.3)
    await _bgmPlayer.setVolume(1.0);

    // 3. 再生開始
    await _bgmPlayer.play(AssetSource('audio/BGM_app.ogg'));
  }

  // --- 公開メソッド ---

  /// BGMの再生を開始
  Future<void> resumeBgm() async {
    // 初回ロードが完了している場合はresumeで、未完了ならplayで開始
    await _bgmPlayer.resume();
  }

  /// BGMを一時停止
  Future<void> pauseBgm() async {
    await _bgmPlayer.pause();
  }

  /// BGMを完全に停止し、リソースを解放する
  void dispose() {
    _bgmPlayer.stop();
    _bgmPlayer.dispose();
  }

  /// BGMの音量を設定
  Future<void> setVolume(double volume) async {
    await _bgmPlayer.setVolume(volume.clamp(0.0, 1.0)); // 0.0〜1.0に制限
  }
}

// サービスを提供するプロバイダ
// ライフサイクルを持つインスタンスなので Provider を使用
final bgmServiceProvider = Provider<BgmService>((ref) {
  // BgmServiceのインスタンスを作成
  final service = BgmService();

  // Providerが破棄されるときに dispose メソッドを呼ぶように登録 (Riverpodの機能)
  ref.onDispose(() {
    service.dispose();
  });

  return service;
});

// App Lifecycle State を監視するための StateProvider
final appLifecycleStateProvider = StateProvider<AppLifecycleState>((ref) {
  return AppLifecycleState.resumed;
});
