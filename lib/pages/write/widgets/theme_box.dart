import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/write/styles/ratio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app_nana_project/providers/theme_provider.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';

class ThemeBox extends ConsumerWidget {
  const ThemeBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(randomSelectorProvider);
    final theme = themeState.selectedTheme;
    final mediaWidth = MediaQuery.of(context).size.width;

    return Container(
      clipBehavior: Clip.antiAlias,
      height: 80,
      width: mediaWidth * Ratio.widthRatio,
      decoration: BoxDecoration(
        color: Color(0xffe3ca49),
        border: Border(bottom: BorderSide(color: MainColors.black, width: 5)),
        borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
      ),
      child: Center(
        child: Text(
          theme,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
