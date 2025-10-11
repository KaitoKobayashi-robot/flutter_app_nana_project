import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/providers/theme_provider.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageArea extends ConsumerWidget {
  final Uint8List imageBytes;
  const ImageArea({super.key, required this.imageBytes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(randomSelectorProvider);
    final theme = themeState.selectedTheme;
    const String assetName = 'assets/images/speech_bubble_2.svg';
    final Widget svg = SvgPicture.asset(
      width: 660,
      assetName,
      semanticsLabel: 'Speech Bubble 2',
    );

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          children: [
            Container(
              height: 80,
              width: 660,
              decoration: BoxDecoration(
                color: Color(0xffe3ca49),
                border: BoxBorder.all(color: MainColors.black, width: 3),
              ),
              child: Center(
                child: Text(
                  theme,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(child: Image.memory(imageBytes, fit: BoxFit.contain)),
          ],
        ),
        Align(alignment: Alignment.bottomCenter, child: svg),
      ],
    );
  }
}
