import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/page_start/widgets/buttons.dart';
import 'package:go_router/go_router.dart';

class PageStart extends StatelessWidget {
  const PageStart({super.key});

  push(BuildContext context) {
    context.push('/setting_theme');
  }

  @override
  Widget build(BuildContext context) {
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
            SingleButton(onPressed: () => push(context)),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
