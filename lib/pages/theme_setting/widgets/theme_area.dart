import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/theme/widgets/speech_bubble.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                Text(
                  textAlign: TextAlign.center,
                  selectedData ?? "",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ],
    );
  }
}
