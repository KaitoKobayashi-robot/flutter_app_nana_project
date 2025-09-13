import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class PageStart extends StatelessWidget {
  const PageStart({super.key});

  push(BuildContext context) {
    context.push('/setting_theme');
  }

  @override
  Widget build(BuildContext context) {
    final nextButton = Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 100),
      width: 430,
      height: 140,
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
            '次へ',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 25,
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
            'next',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 15,
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

    final pushButton = CupertinoButton(
      onPressed: () => push(context),
      child: nextButton,
    );

    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 146),
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: const Text(style: TextStyle(fontSize: 40), '開始画面'),
              ),
            ),
            pushButton,
          ],
        ),
      ),
    );
  }
}
