import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/camera/styles/colors.dart';
import 'package:flutter_app_nana_project/service/se_manager.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SingleButton extends ConsumerWidget {
  const SingleButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoButton(
      onPressed: () {
        ref.read(seManagerProvider).playTapSound();
        onPressed!();
      },
      child: singleButtonBuilder(
        '撮影する',
        'start',
        ButtonColors.readyButtonBgColor,
        ButtonColors.readyButtonTextColor,
      ),
    );
  }
}
