import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

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
}

final randomSelectorProvider =
    StateNotifierProvider<RandomSelectNotifier, String>(
      (ref) => RandomSelectNotifier(),
    );
