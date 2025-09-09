import 'package:flutter_riverpod/flutter_riverpod.dart';

final percentProvider = AutoDisposeNotifierProvider<PercentNotifier, double>(
  () {
    return PercentNotifier();
  },
);

class PercentNotifier extends AutoDisposeNotifier<double> {
  @override
  double build() {
    return 0.00;
  }

  void startIndicator() async {
    if (state != 0.00) return;

    await Future.delayed(const Duration(milliseconds: 500));
    state = 0.20;

    await Future.delayed(const Duration(milliseconds: 500));
    state = 0.40;

    await Future.delayed(const Duration(milliseconds: 500));
    state = 0.60;

    await Future.delayed(const Duration(milliseconds: 500));
    state = 0.80;

    await Future.delayed(const Duration(seconds: 1));
    state = 1.00;

    await Future.delayed(const Duration(seconds: 1));
  }
}
