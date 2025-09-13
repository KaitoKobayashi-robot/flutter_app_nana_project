import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:go_router/go_router.dart';

class PageStart extends StatelessWidget {
  const PageStart({super.key});

  push(BuildContext context) {
    context.push('/setting_theme');
  }

  @override
  Widget build(BuildContext context) {
    final nextButton = singleButtonBuilder('次へ', 'next', buttonMain1);

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
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
