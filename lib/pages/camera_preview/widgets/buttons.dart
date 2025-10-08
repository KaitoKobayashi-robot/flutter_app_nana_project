import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_app_nana_project/pages/camera_preview/styles/colors.dart';

class ReTakeButton extends StatelessWidget {
  const ReTakeButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: doubleButtonBuilder(
        "もう一度撮る",
        "ReTake!",
        ButtonColors.reTakeButtonBgColor,
        ButtonColors.reTakeButtonTextColor,
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: doubleButtonBuilder(
        "次へ",
        "NEXT",
        ButtonColors.nextButtonBgColor,
        ButtonColors.nextButtonTextColor,
      ),
    );
  }
}
