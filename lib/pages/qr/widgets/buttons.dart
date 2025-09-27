import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/qr/styles/colors.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';

class SingleButton extends StatelessWidget {
  const SingleButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: singleButtonBuilder(
        '最初に戻る',
        'Back',
        ButtonColors.buttonBgColor,
        ButtonColors.buttonTextColor,
      ),
    );
  }
}
