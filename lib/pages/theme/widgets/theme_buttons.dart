import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/service/se_manager.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_app_nana_project/pages/theme/styles/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectButton extends ConsumerWidget {
  const SelectButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoButton(
      onPressed: () async {
        await ref.read(seManagerProvider).playTapSound();
        ref.read(seManagerProvider).playDarewoDonoyouni();
        onPressed!();
      },
      child: singleButtonBuilder(
        "えらぶ",
        "next",
        ButtonColors.resetButtonBgColor,
        ButtonColors.resetButtonTextColor,
      ),
    );
  }
}
