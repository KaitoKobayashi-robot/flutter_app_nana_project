import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/service/se_manager.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_app_nana_project/pages/camera_preview/styles/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReTakeButton extends ConsumerWidget {
  const ReTakeButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoButton(
      onPressed: () {
        ref.read(seManagerProvider).playTapSound();
        onPressed!();
      },
      child: doubleButtonBuilder(
        "再撮影する",
        "retake",
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
        "next",
        ButtonColors.nextButtonBgColor,
        ButtonColors.nextButtonTextColor,
      ),
    );
  }
}
