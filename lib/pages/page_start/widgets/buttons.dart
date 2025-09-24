import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/page_start/styles/colors.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';

class SingleButton extends StatelessWidget {
  const SingleButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: doubleButtonBuilder('次へ', 'next', buttonBgColor, buttonTextColor),
    );
  }
}
