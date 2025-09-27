import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/start/widgets/buttons.dart';
import 'package:flutter_app_nana_project/pages/start/widgets/cards.dart';
import 'package:flutter_app_nana_project/pages/start/widgets/logo.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:go_router/go_router.dart';

class PageStart extends StatelessWidget {
  const PageStart({super.key});

  push(BuildContext context) {
    context.push('/terms');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 150),
            Logo(),
            Expanded(child: Center(child: Cards())),
            SingleButton(onPressed: () => push(context)),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
