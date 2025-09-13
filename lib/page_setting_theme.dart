import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class PageSettingTheme extends StatelessWidget {
  const PageSettingTheme({super.key});

  push(BuildContext context) {
    context.push('/camera');
  }

  reset() {
    debugPrint("RESET!");
  }

  @override
  Widget build(BuildContext context) {
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
      onPressed: () => reset(),
      child: resetButtonChild,
    );

    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 146),
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: const Text(style: TextStyle(fontSize: 40), 'お題選択画面'),
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
