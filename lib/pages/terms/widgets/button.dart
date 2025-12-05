import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/terms/styles/colors.dart';
import 'package:flutter_app_nana_project/service/se_manager.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SingleButton extends ConsumerWidget {
  const SingleButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoButton(
      onPressed: () async {
        await ref.read(seManagerProvider).playTapSound();
        ref.read(seManagerProvider).playHomeodai();
        onPressed!();
      },
      child: singleButtonBuilder(
        '次へ',
        'next',
        ButtonColors.buttonBgColor,
        ButtonColors.buttonTextColor,
      ),
    );
  }
}
