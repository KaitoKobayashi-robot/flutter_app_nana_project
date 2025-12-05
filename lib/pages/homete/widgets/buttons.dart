import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/service/se_manager.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_app_nana_project/widgets/logo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HometeButton extends ConsumerWidget {
  const HometeButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoButton(
      onPressed: () {
        ref.read(seManagerProvider).playTapSound();
        onPressed!();
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
        width: 600,
        height: 200,
        decoration: BoxDecoration(
          color: MainColors.mainColor,
          border: Border.all(width: 5, color: MainColors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(padding: const EdgeInsets.all(30), child: Logo()),
      ),
    );
  }
}
