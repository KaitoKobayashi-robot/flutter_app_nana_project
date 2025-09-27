import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/setting_theme/widgets/theme_buttons.dart';
import 'package:flutter_app_nana_project/providers/theme_provider.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageSettingTheme extends ConsumerWidget {
  const PageSettingTheme({super.key});

  push(BuildContext context) {
    context.push('/camera');
  }

  reset(WidgetRef ref) {
    ref.read(randomSelectorProvider.notifier).selectRandomItem();
    debugPrint("RESET!");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedData = ref.watch(randomSelectorProvider);

    return CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            const Text('お題選択画面'),
            Expanded(
              child: Center(
                child: Text(selectedData, style: TextStyle(fontSize: 40)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ResetButton(onPressed: () => reset(ref)),
                NextButton(onPressed: () => push(context)),
              ],
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
