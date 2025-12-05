import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/service/se_manager.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_app_nana_project/pages/theme_setting/styles/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetButton extends ConsumerWidget {
  const ResetButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoButton(
      onPressed: () async {
        await ref.read(seManagerProvider).playTapSound();
        onPressed!();
      },
      child: doubleButtonBuilder(
        "もう一度えらぶ",
        "reselection",
        ButtonColors.resetButtonBgColor,
        ButtonColors.resetButtonTextColor,
      ),
    );
  }
}

class NextButton extends ConsumerWidget {
  const NextButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoButton(
      onPressed: () async {
        await ref.read(seManagerProvider).playTapSound();
        ref.read(seManagerProvider).playTakePhoto();
        onPressed!();
      },
      child: doubleButtonBuilder(
        "次へ",
        "next",
        ButtonColors.nextButtonBgColor,
        ButtonColors.nextButtonTextColor,
      ),
    );
  }
}
