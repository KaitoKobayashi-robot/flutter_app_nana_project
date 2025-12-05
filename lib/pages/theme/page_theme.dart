import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/theme/widgets/theme_buttons.dart';
import 'package:flutter_app_nana_project/service/se_manager.dart';
import 'package:flutter_app_nana_project/widgets/back_button.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_app_nana_project/widgets/logo.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_app_nana_project/pages/theme/widgets/title.dart';
import 'package:flutter_app_nana_project/pages/theme/widgets/theme_area.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PageTheme extends ConsumerWidget {
  const PageTheme({super.key});

  push(BuildContext context) {
    context.push('/setting_theme');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.read(seManagerProvider).playHomeodai();
    final String text =
        '今あなたが思う、\n「ほめたい人」をほめてみよう。\n誰をどのように褒めるのかを決めるために、\n簡単な「ほめお題」を選んでね！';
    return CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: Stack(
        children: [
          Center(
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
                        ThemeArea(selectedData: text),
                        SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  width: ButtonArea.width,
                  height: ButtonArea.height,
                  child: SelectButton(onPressed: () => push(context)),
                ),
              ],
            ),
          ),
          Positioned(top: 50, left: 50, child: BackButton()),
        ],
      ),
    );
  }
}
