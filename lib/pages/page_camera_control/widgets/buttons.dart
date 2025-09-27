import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_app_nana_project/pages/page_camera_control/styles/colors.dart';

class ShowCameraButton extends StatelessWidget {
  const ShowCameraButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: doubleButtonBuilder(
        "カメラ起動",
        "READY!",
        ButtonColors.readyButtonBgColor,
        ButtonColors.readyButtonTextColor,
      ),
    );
  }
}

class TakePhotoButton extends StatelessWidget {
  const TakePhotoButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: doubleButtonBuilder(
        "撮影",
        "Take Photo!",
        ButtonColors.captureButtonBgColor,
        ButtonColors.captureButtonTextColor,
      ),
    );
  }
}
