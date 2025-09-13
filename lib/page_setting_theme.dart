import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/theme_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
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

    final resetButtonChild = Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: 320,
      height: 100,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 253, 141, 255),
        borderRadius: BorderRadius.circular(70),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 10),
            blurRadius: 3,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '選びなおす',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(0, 3),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
          const Text(
            'Reset',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(0, 3),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final nextButtonChild = Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: 320,
      height: 100,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(70),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 10),
            blurRadius: 3,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '次へ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(0, 3),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
          const Text(
            'NEXT',
            style: TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(0, 3),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final nextButton = CupertinoButton(
      onPressed: () => push(context),
      child: nextButtonChild,
    );

    final resetButton = CupertinoButton(
      onPressed: () => reset(ref),
      child: resetButtonChild,
    );

    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 146),
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
              children: [resetButton, nextButton],
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
