import 'package:flutter/cupertino.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'だれを？どのように？ほめて！',
      style: TextStyle(fontSize: 45, fontWeight: FontWeight.w900),
    );
  }
}
