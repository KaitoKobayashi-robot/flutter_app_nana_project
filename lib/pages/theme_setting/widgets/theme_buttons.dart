import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_app_nana_project/pages/theme_setting/styles/colors.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: doubleButtonBuilder(
        "もう一度えらぶ",
        "reselection",
        ButtonColors.resetButtonBgColor,
        ButtonColors.resetButtonTextColor,
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
        "next",
        ButtonColors.nextButtonBgColor,
        ButtonColors.nextButtonTextColor,
      ),
    );
  }
}
