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
  RandomSelectNotifier() : super(const ThemeState()) {
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

    state = state.copyWith(isLoading: true);

    timer = Timer.periodic(Duration(microseconds: 100), (Timer t) {
      selectRandomItem();
    });

    Future.delayed(Duration(seconds: 1), () {
      timer?.cancel();
      state = state.copyWith(isLoading: false);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

final randomSelectorProvider =
    StateNotifierProvider<RandomSelectNotifier, ThemeState>(
      (ref) => RandomSelectNotifier(),
    );
