import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/camera_preview/styles/ratio.dart';
import 'package:flutter_app_nana_project/pages/camera_preview/widgets/theme_box.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageArea extends ConsumerWidget {
  final Uint8List imageBytes;
  const ImageArea({super.key, required this.imageBytes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaWidth = MediaQuery.of(context).size.width;

    const String assetName = 'assets/images/speech_bubble_2.svg';
    final Widget svg = SvgPicture.asset(
      width: mediaWidth * Ratio.widthRatio,
      assetName,
      semanticsLabel: 'Speech Bubble 2',
    );

    return Column(
      children: [
        ThemeBox(),
        Stack(
          alignment: Alignment.center,
          children: [
            Image.memory(
              imageBytes,
              fit: BoxFit.contain,
              width: mediaWidth * Ratio.widthRatio,
            ),
            Positioned(bottom: 0, child: svg),
          ],
        ),
      ],
    );
  }
}
