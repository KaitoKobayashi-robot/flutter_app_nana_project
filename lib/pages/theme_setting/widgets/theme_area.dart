import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/theme_setting/widgets/speech_bubble.dart';

class ThemeArea extends StatelessWidget {
  final String? selectedData;
  const ThemeArea({super.key, this.selectedData});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SpeechBubble(),
        Column(
          children: [
            Text(
              selectedData ?? "",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
          ],
        ),
      ],
    );
  }
}
