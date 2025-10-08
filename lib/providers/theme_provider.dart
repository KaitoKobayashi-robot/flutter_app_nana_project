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

class RandomSelectNotifier extends StateNotifier<String> {
  RandomSelectNotifier() : super('') {
    selectRandomItem();
  }

  void selectRandomItem() {
    final random = Random();
    final randomIndex = random.nextInt(allThemes.length);
    state = allThemes[randomIndex];
  }

  Timer? timer;
  void startAutoSelect() {
    if (timer?.isActive ?? false) return;
    timer = Timer.periodic(Duration(microseconds: 100), (Timer t) {
      selectRandomItem();
    });
    Future.delayed(Duration(seconds: 1), () {
      timer?.cancel();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

final randomSelectorProvider =
    StateNotifierProvider<RandomSelectNotifier, String>(
      (ref) => RandomSelectNotifier(),
    );
