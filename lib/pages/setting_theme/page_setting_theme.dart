import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/setting_theme/widgets/theme_buttons.dart';
import 'package:flutter_app_nana_project/pages/setting_theme/widgets/title.dart';
import 'package:flutter_app_nana_project/providers/theme_provider.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_app_nana_project/widgets/logo.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app_nana_project/pages/setting_theme/widgets/theme_area.dart';

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
            SizedBox(height: 70),
            Logo(height: 100),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleWidget(),
                    SizedBox(height: 100),
                    ThemeArea(selectedData: selectedData),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ResetButton(onPressed: () => reset(ref)),
                NextButton(onPressed: () => push(context)),
              ],
            ),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
