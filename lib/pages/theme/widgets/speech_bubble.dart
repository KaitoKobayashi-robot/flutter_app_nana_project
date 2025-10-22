import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpeechBubble extends StatelessWidget {
  const SpeechBubble({super.key});

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/images/speech_bubble_1.svg';
    final Widget svg = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Speech Bubble',
      height: 550,
    );
    return svg;
  }
}
