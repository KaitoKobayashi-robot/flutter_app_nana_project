import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_app_nana_project/pages/page_setting_theme/styles/colors.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: doubleButtonBuilder(
        "選びなおす",
        "RESET!",
        resetButtonBgColor,
        resetButtonTextColor,
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
        nextButtonBgColor,
        nextButtonTextColor,
      ),
    );
  }
}
