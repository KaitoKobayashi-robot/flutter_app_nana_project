import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/theme_setting/widgets/theme_buttons.dart';
import 'package:flutter_app_nana_project/pages/theme_setting/widgets/title.dart';
import 'package:flutter_app_nana_project/providers/theme_provider.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_app_nana_project/widgets/logo.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app_nana_project/pages/theme_setting/widgets/theme_area.dart';

class PageSettingTheme extends ConsumerStatefulWidget {
  const PageSettingTheme({super.key});

  @override
  ConsumerState<PageSettingTheme> createState() => _PageSettingThemeState();
}

class _PageSettingThemeState extends ConsumerState<PageSettingTheme> {
  final triggerDocRef = FirebaseFirestore.instance
      .collection('camera')
      .doc('trigger');

  push() {
    final theme = ref.read(randomSelectorProvider).selectedTheme;
    triggerDocRef.update({'theme': theme});
    context.push('/camera');
  }

  reset() {
    ref.read(randomSelectorProvider.notifier).startAutoSelect();
    debugPrint("RESET!");
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(randomSelectorProvider.notifier).startAutoSelect();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(randomSelectorProvider);
    final selectedData = themeState.selectedTheme;
    final isLoading = themeState.isLoading;

    return CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 70),
            Logo(),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 170, 0, 30),
                      child: TitleWidget(),
                    ),
                    ThemeArea(selectedData: selectedData),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: ButtonArea.width,
              height: ButtonArea.height,
              child: !isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ResetButton(onPressed: () => reset()),
                        NextButton(onPressed: () => push()),
                      ],
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
