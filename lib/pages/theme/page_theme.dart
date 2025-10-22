import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/theme/widgets/theme_buttons.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_app_nana_project/widgets/logo.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_app_nana_project/pages/theme/widgets/title.dart';
import 'package:flutter_app_nana_project/pages/theme/widgets/theme_area.dart';
import 'package:go_router/go_router.dart';

class PageTheme extends StatelessWidget {
  const PageTheme({super.key});

  push(BuildContext context) {
    context.push('/setting_theme');
  }

  @override
  Widget build(BuildContext context) {
    final String text =
        '身近な人や最近会えていない人、\n普段は恥ずかしくて言えない人をほめてみよう。\n誰をどのようにほめるのかを決める為に、\n簡単な「ほめお題」を選んでね！';
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
                    SizedBox(height: 130),
                    ThemeArea(selectedData: text),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: ButtonArea.width,
              height: ButtonArea.height,
              child: SelectButton(onPressed: () => push(context)),
            ),
          ],
        ),
      ),
    );
  }
}
