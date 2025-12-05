import 'package:flutter_app_nana_project/service/se_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import 'dart:async';

const List<String> allThemes = [
  'かわいくほめて！',
  'まじめにほめて！',
  'キザにほめて！',
  'おもしろくほめて！',
  '詩的にほめて！',
  '心を込めてほめて！',
  '先生っぽくほめて！',
  'こっそりほめて！',
  'ドラマチックにほめて！',
  '最近ちょっと頑張ったことをほめて！',
  '自分を自分らしくほめて！',
  '昔の自分をほめて！',
  '未来の自分をほめて！',
  '昨日の自分をほめて！',
  'オーディションの審査員っぽくほめて！',
  'ドヤ顔でほめて！',
  '家族をほめて！',
  '本当は一番言いたい「あの人」をほめて！',
  '今日出会った誰かをほめて！',
  '最近会えていないあの子を褒めて！',
  'あのとき言えなかったことを思い出してほめて！',
];

class ThemeState {
  final String selectedTheme;
  final bool isLoading;
  const ThemeState({this.selectedTheme = '', this.isLoading = false});

  ThemeState copyWith({String? selectedTheme, bool? isLoading}) {
    return ThemeState(
      selectedTheme: selectedTheme ?? this.selectedTheme,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class RandomSelectNotifier extends StateNotifier<ThemeState> {
  final SeManager _seManager;
  RandomSelectNotifier(this._seManager) : super(const ThemeState()) {
    selectRandomItem();
  }

  void selectRandomItem() {
    final random = Random();
    final randomIndex = random.nextInt(allThemes.length);
    state = state.copyWith(selectedTheme: allThemes[randomIndex]);
  }

  Timer? timer;
  void startAutoSelect() {
    if (state.isLoading) return;

    _seManager.playDrumRoll();
    state = state.copyWith(isLoading: true);

    timer = Timer.periodic(Duration(milliseconds: 20), (Timer t) {
      selectRandomItem();
    });

    Future.delayed(Duration(seconds: 2), () {
      timer?.cancel();
      state = state.copyWith(isLoading: false);
      _seManager.stopDrumRoll();
      _seManager.playDenn();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

final randomSelectorProvider =
    StateNotifierProvider<RandomSelectNotifier, ThemeState>((ref) {
      final seManager = ref.read(seManagerProvider);
      return RandomSelectNotifier(seManager);
    });
