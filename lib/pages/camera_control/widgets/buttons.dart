import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_app_nana_project/pages/camera_control/styles/colors.dart';

class TakePhotoButton extends StatelessWidget {
  const TakePhotoButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: singleButtonBuilder(
        "撮影する",
        "start",
        ButtonColors.captureButtonBgColor,
        ButtonColors.captureButtonTextColor,
      ),
    );
  }
}
