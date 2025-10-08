import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_app_nana_project/pages/theme/styles/colors.dart';

class SelectButton extends StatelessWidget {
  const SelectButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: singleButtonBuilder(
        "えらぶ",
        "next",
        ButtonColors.resetButtonBgColor,
        ButtonColors.resetButtonTextColor,
      ),
    );
  }
}
